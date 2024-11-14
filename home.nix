{ config, pkgs, ... }:


let
  myAliases = {
      ll = "ls -l";
      ".." = "cd ..";
  };
in
{
  
  home.username = "nuks";
  home.homeDirectory = "/home/nuks";

  
  home.stateVersion = "24.05"; 


  home.packages = with pkgs; [
  
  ];

  home.file = {
    
   }

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.bash = {
    enable = true;
    shellAliases = myAliases;
  };
  programs.zsh = { 
   enable = true;
   shellAliases = myAliases;
  };
  

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
}
