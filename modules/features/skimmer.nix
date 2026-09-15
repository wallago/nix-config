{ inputs, ... }: {
  flake.nixosModules.skimmer = { config, ... }: {
    imports = [ inputs.skimmer.nixosModules.default ];

    services.skimmer = {
      enable = true;
      verbose = 1;
      settings = {
        output = "/home/wallago/sync-notes/skimmer/";
        reader = ''
          Software architect and Rust developer. Builds CLIs and TUIs, edits in Neovim,
          runs NixOS with flakes everywhere, self-hosts own infrastructure.
          Already knows the basics — no explainers, no "what is X" framing. Lead with
          what actually changed and whether it's worth acting on.
          Prefers primary sources and technical depth over commentary. Wants the
          tradeoff, not the pitch.
          Skip: funding rounds, crypto, beginner tutorials, language wars, release
          notes with nothing behind them, AI model launch PR.
        '';
        miniflux = {
          url = "https://${config.preferences.miniflux.url}";
          username = "admin";
          password_file = config.sops.secrets."miniflux-admin-password".path;
        };
        claude = {
          model = "claude-haiku-4-5";
          api_key_file = config.sops.secrets."claude-api-key".path;
        };
        topic = {
          github = {
            question = "Which trending GitHub repositories from the past week are worth a closer look?";
            feeds = [
              "Github Trend"
            ];
            interval = "7d";
            context = ''
              For each pick: what it does in one line, the language, and whether it's production-grade,
              a promising early project, or a demo riding a hype wave.
              Say what existing tool it competes with or replaces.
              Favour Rust, CLI/TUI, Nix, self-hosting, dev tooling and infrastructure.
              Skip awesome-lists, course/interview-prep repos, prompt collections and thin AI wrappers.
            '';
          };
          terminal = {
            question = "What new CLI/TUI tools or terminal workflows came up the past day?";
            feeds = [
              "Reddit CLI"
              "Reddit TUI"
            ];
            interval = "24h";
            context = ''
              Keep a tool only if it beats an established one at something concrete; name what it replaces
              (fzf, ripgrep, lazygit, btop, yazi, zellij…) and what it does better.
              For each: language, maturity (daily-driver or weekend project), and whether it's packaged in nixpkgs.
              Rust and ratatui projects are welcome, but note when a TUI is just a skin over an existing CLI.
              Workflow posts count only if they show a technique worth stealing, not a dotfiles tour.
              Skip screenshot-only posts, theme/prompt showcases, "which terminal should I use" threads, and AI chat wrappers.
              If nothing clears the bar, say so in one line.
            '';
          };
          rust = {
            question = "What's going on interesting in the Rust world the past day?";
            feeds = [
              "Reddit Rust"
              "This Week in Rust"
              "Rust Blog"
              "Inside Rust Blog"
            ];
            interval = "24h";
            context = ''
              Async internals, TUI/CLI crates, build tooling, compiler work, lib, framework (anything interesting as developer). 
              Flag crates stable enough to actually depend on, and say plainly when something is a weekend project. 
              Breaking changes and MSRV bumps matter.
              New documentations or interesting discussions.
            '';
          };
          nix = {
            question = "What's new or noteworthy in the Nix/NixOS ecosystem the past day?";
            feeds = [
              "NixOS Discourse"
              "Reddit NixOS"
              "NixOS Weekly"
              "Determinate Systems blog"
            ];
            interval = "24h";
            context = ''
              Flakes, module system and packaging changes that affect a personal NixOS config. 
              Flag anything breaking on unstable. 
              New tools to improve project environments or configs.
              Determinate Systems posts: keep what changes Nix itself or upstream behaviour; one line for FlakeHub/product announcements.
              Skip 'I rebuilt my config' posts unless the technique is new.
            '';
          };
          neovim = {
            question = "Any new Neovim releases, plugins or config tricks worth knowing from the past day?";
            feeds = [
              "Neovim News"
              "Reddit Neovim"
              "Release notes from neovim"
            ];
            context = ''
              Core releases and LSP/treesitter changes first, then plugins that replace something already in a config. 
              New tools / plugins worth to look at.
              Skip dotfile showcases and colorscheme posts.
            '';
            interval = "24h";
          };
          linux = {
            question = "What happened in the Linux kernel, distros and desktop stack the past day?";
            feeds = [
              "LWN"
              "Phoronix"
              "Reddit Linux"
            ];
            interval = "24h";
            context = ''
              Kernel and filesystem work first, then distro changes that reach NixOS. 
              Anything to be worth to be aware.
              Phoronix benchmark churn and desktop drama are low priority unless something real landed.
            '';
          };
          selfhosted = {
            question = "What's interesting in self-hosting the past week?";
            feeds = [
              "Reddit Self Hosted"
              "selfh.st"
            ];
            interval = "24h";
            context = ''
              Self-hosting and homelab new tools or update worth to be aware. 
            '';
          };
          devops = {
            question = "What's interesting in self-hosting the past week?";
            feeds = [
              "Reddit Devops"
            ];
            interval = "24h";
            context = ''
              DevOps new tools or update worth to be aware. 
              Interesting about deployment, observability, CI.
            '';
          };
          infra = {
            question = "What's interesting in infrastructure the past week?";
            feeds = [
              "Cloudflare Blog"
            ];
            interval = "24h";
            context = "";
          };
          sport = {
            question = "What happened in cycling, trail running and climbing the past week?";
            feeds = [
              "Velo News"
              "iRunFar"
              "Climbing"
            ];
            interval = "168h";
            context = ''
              One section per sport: cycling, trail/ultra, climbing. Leave a section out if nothing clears the bar.
              Cycling: major races and results only, no transfer gossip.
              Trail/ultra: race results only for major events; prefer training, gear that lasts, and European ultras.
              Climbing: hard ascents, training and technique.
              Skip listicles, sponsored gear roundups, gym-industry news and gear marketing.
            '';
          };
          videos = {
            question = "Which new tech videos from the past day are worth watching, and what does each one cover?";
            feeds = [
              "Youtube Vimjoyer"
              "Youtube DevOps Toolbox"
            ];
            context = ''
              Say concretely what each video covers so it's clear whether it's worth the runtime. 
              Both channels re-tread ground — flag when a video does.
            '';
            interval = "24h";
          };
          security = {
            question = "What notable vulnerabilities, breaches or security research came out the past week?";
            feeds = [
              "Schneier on Security"
              "Krebs on Security"
              "Port Swigger"
              "Project Zero"
            ];
            interval = "168h";
            context = ''
              Lead with anything touching the stack actually run: Linux, Rust crates, self-hosted services behind a reverse proxy, Cloudflare.
              For each, say whether action is needed. Research is interesting for the technique, not the CVE count.
              Skip enterprise and compliance news.
            '';
          };
          blogs = {
            question = "Which in-depth programming or hardware articles from the past week are worth reading?";
            feeds = [
              "Drew DeVault"
              "Julia Evans"
              "Bunnie's blog"
              "Tweag - Engineering blog"
              "Faster than lime"
            ];
            interval = "168h";
            context = ''
              Long-form only — pick the few worth 20 minutes and say why for each.
              Depth over topicality; an older idea explained well beats a news post.
              Hardware and low-level work welcome.
              Tweag posts: favour Nix, build systems and Rust; one line for Haskell or client-case-study posts.
            '';
          };
          ai = {
            question = "What happened in AI tooling since the last briefing?";
            feeds = [
              "Hugging Face - Blog"
              "Reddit Claude"
              "Import AI"
              "Simon Willison's Weblog"
              "Interconnects AI"
              "Ahead of AI"
              "Reddit LocalLLaMA"
            ];
            context = "
              Only what changes how software actually gets built: coding agents, local model tooling, 
              inference on own hardware, API and pricing changes with real impact. 
              For release feeds, list only user-facing changes and anything breaking. 
              Benchmark claims and model launches get one line unless something is genuinely usable now. 
              Skip funding, org drama, and AGI commentary.
            ";
            interval = "24h";
          };
          hardware = {
            question = "What hardware hacks and electronics projects from the past week are worth a look?";
            feeds = [ "Hackaday" ];
            interval = "168h";
            context = ''
              Pick the handful with real engineering detail: reverse engineering, firmware, RF, PCB design,
              repair/right-to-repair, clever builds with documented schematics or code.
              Skip retro-nostalgia fluff, 3D-print showcases, and posts that just link a video with no writeup.
              If nothing clears the bar, say so in one line.
            '';
          };
          programming = {
            question = "What were the most discussed programming and tech stories the past day?";
            feeds = [
              "Reddit Programming"
              "Hacker News"
            ];
            interval = "24h";
            context = ''
              Rank by technical substance, not vote count.
              Prefer engineering writeups, postmortems, language/compiler design and infrastructure stories.
              Skip anything already covered by a more specific topic (Rust, Nix, Neovim, Linux, AI, security).
              Skip career advice, hiring threads, "is X dead" debates and language wars.
              If nothing clears the bar, say so in one line.
            '';
          };
          zomboid = {
            question = "What's new in Project Zomboid the past week: dev updates, patches, and mods worth installing?";
            feeds = [
              "Project Zomboid"
              "Reddit projectzomboid"
            ];
            interval = "168h";
            context = ''
              Lead with Indie Stone dev updates (Thursdoids) and build announcements: what's actually coming and roughly when.
              Patch notes: gameplay and balance changes, save-breaking changes, and anything that breaks mods; one line for pure bugfix hotfixes.
              Note which branch a change lands on (stable, unstable, legacy).
              Reddit: keep only standout mods (say what they change and whether they work on the current build) and gameplay techniques worth stealing.
              Skip death stories, base screenshots, memes, "is it worth buying" threads and server ads.
              If nothing clears the bar, say so in one line.
            '';
          };
        };
      };
    };
  };
}
