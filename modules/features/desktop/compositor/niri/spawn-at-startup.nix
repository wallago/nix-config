{
  flake.homeModules.niriSpawnAtStartup =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    let
      # niri's `open-on-workspace` window rule only applies at map time, so it
      # misses whenever an app sets its title after mapping. Place the window
      # explicitly instead, keyed on the pid we spawned rather than on focus:
      # `move-window-to-workspace` without --window-id acts on the *focused*
      # window, which races when several session entries start at once.
      placeOnWorkspace =
        e:
        pkgs.writeShellScript "session-${baseNameOf (builtins.head e.command)}-${e.workspace}" ''
          ${lib.escapeShellArgs e.command} &
          pid=$!
          for _ in $(seq 1 40); do
            id=$(niri msg --json windows \
              | ${lib.getExe pkgs.jq} -r --argjson p "$pid" 'map(select(.pid == $p))[0].id // empty')
            if [ -n "$id" ]; then
              niri msg action move-window-to-workspace \
                --window-id "$id" --focus false ${lib.escapeShellArg e.workspace}
              break
            fi
            sleep 0.25
          done
          wait
        '';
    in
    {
      programs.niri.settings.spawn-at-startup =
        map (
          e:
          if e.workspace == null then { inherit (e) command; } else { command = [ "${placeOnWorkspace e}" ]; }
        ) config.preferences.session
        ++ [
          {
            command = [
              "niri"
              "msg"
              "action"
              "switch-layout"
              "1"
            ];
          }
        ];
    };
}
