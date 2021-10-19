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
**did not work for me** so I [downloaded the tar file](https://www.jetbrains.com/idea/download/#section=linux) and then followed the [steps](https://www.jetbrains.com/help/idea/installation-guide.html#standalone)

After downloading it (default browser download location is `My files/Downloads`) drag and drop the file (usually of the form `ideaIC-20xx.y.z.tar.gz`) or copy the files into `Linux files` (`My files/Linux files`).
Then,
```
sudo tar -xzf ideaIU.tar.gz -C /opt
```
This automatically creates `/opt` directory and it is the [recommended location.](https://www.jetbrains.com/help/idea/installation-guide.html#standalone)
Go to the extracted location
```
cd /opt/idea-IC-123.4567.89/bin
```
**To start IntelliJ Idea do `bash idea.sh`**
```
sudo apt install -y git kile inkscape gimp
```
