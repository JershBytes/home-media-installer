<p align="center">
  <img src="assets/images/IMG_0725.png" alt="Header" height="30%" width="30%">
  <h3 align="center"> Home Media Installer </h3>
</p>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![GitHub Issues](https://img.shields.io/github/issues/coloredbytes/home-media-installer.svg)](https://github.com/coloredbytes/home-media-installer/issues)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE) <br>
<i> Your AIO Home Media Server Installer </i>


</div>

# :link: Table of Contents

- [:link: Table of Contents](#link-table-of-contents)
  - [:x: Problem](#x-problem)
  - [:heavy\_check\_mark: Solution](#heavy_check_mark-solution)
  - [:gear: Instructions](#gear-instructions)
  - [:memo: Notes](#memo-notes)


## :x: Problem

I had on my **GitHub** 3 separate repos for **Plex** ,**Emby**, and **Jellyfin**. I got to thinking though why not just converge them all into one? So when people want to install one of them they don't need to install clone 3 different repos. Unless That's what you're into.

## :heavy_check_mark: Solution

The answer came to me when I asked **ChatGPT** a simple question. 
- **What would be a good name for a Repo with a script that can install plex ,emby or jellyfin?**

As Usual, it spit out 10 answers but one stuck to me.  Home Media Installer . It stuck to me because this gives us the flexibility to install whatever media server we want. So I grabbed the 3 scripts I had made a whiptail menu for the front page and this **Home Media Installer** was born.

## :gear: Instructions
- Run the script.

```shell
curl -fsSL https://raw.githubusercontent.com/coloredbytes/home-media-installer/refs/heads/main/menu.sh | bash
```



## :memo: Notes
> [!NOTE]
> This runs on most Debian and RHEL Systems and has been tested for compatibility.
