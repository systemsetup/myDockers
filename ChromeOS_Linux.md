```
sudo passwd root
sudo apt update
sudo apt list --upgradable
```
## [IntelliJ Idea](https://www.jetbrains.com/idea/download/#section=linux)
```
sudo snap install intellij-idea-community --classic
```
The [snap approach](https://www.jetbrains.com/help/idea/installation-guide.html#snap)
```
sudo apt install snapd
sudo snap install intellij-idea-community --classic
```
**did not work for me** so I [downloaded the tar file](https://www.jetbrains.com/idea/download/#section=linux) and then followed the [steps.](https://www.jetbrains.com/help/idea/installation-guide.html#standalone)

After downloading it (default browser download location is `My files/Downloads`) drag and drop the file (usually of the form `ideaIC-20xx.y.z.tar.gz`) or copy the files into `Linux files` (`My files/Linux files`).
Then,
```
sudo tar -xzf ideaIC-20xx.y.z.tar.gz -C /opt
```
This automatically creates `/opt` directory and it is the [recommended location.](https://www.jetbrains.com/help/idea/installation-guide.html#standalone)
Go to the extracted location
```
cd /opt/idea-IC-123.4567.89/bin
```
**To start IntelliJ Idea do `bash idea.sh`**

## [Zotero](https://www.zotero.org/download/)

[Download the tar file](https://www.zotero.org/download/) and then follow the [steps.](https://www.zotero.org/support/installation)

Like above copy the downloaded files into `Linux files`, then
```
sudo tar -xf Zotero-X.Y.AB.C_linux-x86_64.tar.bz2 -C /opt
```
Note that (inside the terminal) if you are already in some directory you need to be in root `cd ~/.` to use the above command.
Go to the extracted location
```
cd /opt/Zotero_linux-x86_64/
```
**To start Zotero do `bash zotero`**

### Symbolic link in the root directory to the executables

To avoid repeatedly typing `cd /opt/<directory-name-of-executatble>` create a symbolic link in the root `/home/<username>` as follows
```
ln -s /opt/idea-IC-123.4567.89/bin/idea.sh /home/<username>/idea
ln -s /opt/Zotero_linux-x86_64/zotero /home/<username>/zotero
```
Then, everytime you open the terminal (you will be in `/home/<username>`) to run the desired executable just do `bash idea` or `bash zotero`.

## [Leiningen](https://leiningen.org/)
```
sudo apt install default-jdk
java -version
```
Until recently the [Leiningen website](https://leiningen.org/) used to explicitly recommend OpenJDK-8 (`sudo apt install openjdk-8-jdk`) but now no recommendations regarding the version of OpenJDK is given.
```
sudo apt install leiningen
```

## Other Softwares
```
sudo apt install -y git kile inkscape gimp
```
