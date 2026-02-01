{ config, pkgs, inputs, ... }:

let
  mybotPkg = inputs.agnabot.outputs.packages.${pkgs.system}.default;
in {
  systemd.services.agnabot = {
    description = "agnabot discord bot";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = "${mybotPkg}/bin/agnabot";
      Restart = "always";
      User = "agnab";
    };
  };
}
