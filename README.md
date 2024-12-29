# PluginParadise
By default, qBittorrent does not come with any search plugins installed. Users are encouraged to visit the qbittorrent/search-plugins repository to choose and download the plugins they desire:

![02](https://github.com/user-attachments/assets/6a8103c1-3b21-44ac-9d61-d2cbb79337d8)

The page is located here:
https://github.com/qbittorrent/search-plugins/wiki/Unofficial-search-plugins

How awesome would it be to automate this process?

I made a script that automates the download of the public ones.

On Linux, it's a Python script. Run this command:

```
git clone https://github.com/michaeljh9/PluginParadise.git && cd PluginParadise && python qbittorrent-search-plugin-downloader.py
```
On Windows, it's a Powershell script. Run this command:

```
irm https://raw.githubusercontent.com/michaeljh9/PluginParadise/main/qbt-plugin-downloader.ps1 | iex
```
It creates a folder located at ~/Desktop titled 'engines' and downloads the search plugins:

![03](https://github.com/user-attachments/assets/45c56508-e89c-4ccc-8ce6-3924401ec3cf)

When it's all done, it tells you where they are with steps on how to import them:

![04](https://github.com/user-attachments/assets/fa5736b3-5f9e-49d3-b7d6-b91ae9c0a95c)

First, have the search tab enabled:

![01](https://github.com/user-attachments/assets/7c89e2f5-a039-4ad1-a24d-d6ab3d1ea14e)

Click on the 'Search Plugins...' button in the lower-right corner:

![05](https://github.com/user-attachments/assets/3eb03276-2230-4552-afb5-7f51a357b1e9)

The 'Search plugins' window appears. Click on the 'Install a new one' button. Click on the 'Local file' button. Navigate to the folder where the script downloaded all of the plugins. Type ctrl + a to select all to get all of them. Click the Open button. Wait half a minute while qBittorrent makes it happen.

You'll get an error if any plugins are unsupported. In my example, this is the only one that wasn't happy and because it's a search site I don't regularly use, I'll live another day.

![06](https://github.com/user-attachments/assets/38829b25-cdcc-4f32-9591-182cfca516af)

You now have an all-in-one, one-stop-shop place to search the internet for your Linux ISOs! Enjoy!

![07](https://github.com/user-attachments/assets/7a71d8c7-2ee7-4372-8c3b-c15770981643)

![08](https://github.com/user-attachments/assets/77f7a1f3-4940-404f-96d9-d0026adfef34)
