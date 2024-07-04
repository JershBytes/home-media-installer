<p align="center">
  <img src="./assets/images/github-header-image.png" alt="Header">
  <a href="https://opensource.org/licenses/MIT">
    <img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT">
  </a>
</p>

# :link: Table of Contents

- [:x: Problem](#x-problem)
- [:heavy\_check\_mark: Solution](#heavy_check_mark-solution)
- [:gear: Instructions](#gear-instructions)
- [:memo: Notes](#memo-notes)


## :x: Problem

I had on my **GitHub** 3 separate repos for **Plex** ,**Emby**, and **Jellyfin**. I got to thinking though why not just converge them all into one? So when people want to install one of them they don't need to install clone 3 different repos. Unless That's what you're into.

## :heavy_check_mark: Solution

The Answer came to when I asked **ChatGPT** a simple question. 
- **What would be a good name for a Repo with a script that can install plex ,emby or jellyfin?**

As Usual, it spit out 10 answers but one stuck to me. FlexMediaInstaller. It stuck to me because this gives us the flexibility to install whatever media server we want. So I grabbed the 3 scripts I had made a whiptail menu for the front page and this **FlexMediaInstaller** was born.

## :gear: Instructions

- Clone the Repo.
```
https://github.com/ColoredBytes/FlexMediaInstaller.git
```
- Change into the directory and run the script.

```bash
cd FlexMediaInstaller; ./menu.sh
```


## :memo: Notes
> [!NOTE]
> This runs on most Debian and RHEL Systems and has been tested for compatibility.
