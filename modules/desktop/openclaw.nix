{ config, pkgs, inputs, lib, ... }:

let
  # Grab the package we just tested
  openclawPkg = inputs.openclaw.packages.${pkgs.system}.default;

  # Define the Config (JSON5)
  # We put non-secret config here.
  openclawConfig = pkgs.writeText "openclaw.json5" (builtins.toJSON {
    gateway = {
      mode = "local";
      bind = "127.0.0.1";
      port = 8080;
      auth = { mode = "token"; };
    };

    channels = {
      telegram = {
        enabled = true;
        dmPolicy = "pairing"; 
        # REPLACE with your numeric ID from @userinfobot
        allowFrom = [ 12345678 ]; 
        configWrites = false; 
      };
    };

    models = {
      providers = {
        ollama = {
          baseUrl = "http://127.0.0.1:11434";
        };
      };
    };

    agents = {
      defaults = {
        model = {
          primary = {
            provider = "ollama";
            model = "gemma3:latest"; # Ensure you have pulled this!
          };
        };
        workspace = "/home/agnab/.openclaw/workspace";
      };
    };
  });

in
{
  # Import the module to get necessary groups/users if defined (optional but safe)
  # imports = [ inputs.openclaw.nixosModules.default ]; 
  # Note: Since there is no nixosModule, we skip the import and define service manually.

  systemd.services.openclaw = {
    description = "OpenClaw Sovereign Agent";
    after = [ "network.target" "ollama.service" ];
    wantedBy = [ "multi-user.target" ];

    # Add tools to the path so the agent can find them
    path = with pkgs; [ 
      openclawPkg
      git 
      curl 
      jq 
      ripgrep 
      python3 
      nodejs
    ];

    serviceConfig = {
      User = "agnab";
      Group = "users";
      WorkingDirectory = "/home/agnab";

      # Point to the Nix-generated config
      Environment = "OPENCLAW_CONFIG_PATH=${openclawConfig}";
      
      # Load secrets (Tokens) from this unmanaged file
      EnvironmentFile = "-/var/lib/openclaw/.env";

      # The Command we just verified
      ExecStart = "${openclawPkg}/bin/openclaw gateway";
      
      Restart = "always";
      RestartSec = "5s";
    };
  };

  # System Integration
  environment.systemPackages = [ openclawPkg ];
  networking.firewall.allowedTCPPorts = [ 8080 ];
  
  # Ensure the secrets directory exists
  systemd.tmpfiles.rules = [
    "d /var/lib/openclaw 0700 agnab users -"
  ];
}
