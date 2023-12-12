###### Android
# adb push ~/Desktop/wx_wxapkgfind.sh /sdcard/
# cp /sdcard/wx_wxapkgfind.sh /&&chmod +x /wx_wxapkgfind.sh&&/wx_wxapkgfind.sh
###### IOS
# scp ~/Desktop/wx_wxapkgfind.sh root@kios.local:~/
# chmod +x wx_wxapkgfind.sh&&~/wx_wxapkgfind.sh
###### 解包
# /opt/homebrew/bin/node ~/tools/tool/04tools/0403-Data_analysis/0303-加密解密/小程序解包/wxcha11/02jiebao/wxappUnpackerNew/wuWxapkg.js <wxapkg主包>
# /opt/homebrew/bin/node ~/tools/tool/04tools/0403-Data_analysis/0303-加密解密/小程序解包/wxcha11/02jiebao/wxappUnpackerNew/wuWxapkg.js -s=<主包解压路径> <wxapkg分包>

# 设置红色文本颜色
RED='\033[0;31m'
# 设置绿色文本颜色
GREEN='\033[0;32m'
# 设置黄色文本颜色
YELLOW='\033[0;33m'
# 设置重置颜色
RESET='\033[0m'

echo "# ++++++++++++++++++++++++++++++++++++++++++"
echo "# +  微信公众号：攻有道       By:Cha111Ng1    +"
echo "# ++++++++++++++++++++++++++++++++++++++++++"
echo ""

# 安卓
cha11_Android() {
    echo "${GREEN}[*]进入微信目录->${RESET} cd /data/data/com.tencent.mm/MicroMsg"
    cd /data/data/com.tencent.mm/MicroMsg
    echo "${GREEN}[*]查看系统当前.wxapkg包->${RESET} find ./ -name *.wxapkg"
    find ./ -name *.wxapkg
    echo ""
    echo "${YELLOW}[+]自动执行删除所有.wxapkg->${RESET} find ./ -name "*.wxapkg" -exec rm {} \;"
    find ./ -name "*.wxapkg" -exec rm {} \;
    echo ""

    echo "${GREEN}[*]请输入小程序的名称:${RESET}"
    read userInputfile

    echo ""
    mkdir -p /sdcard/xcx/$userInputfile

    echo "${GREEN}[*]请在手机上打开需要测试的小程序${RESET}"
    echo "${RED}[*]请确认是否已打开小程序 '确认-> y' 或 'n': ${RESET}"
    # 提示用户输入
    read userInput
    # 判断输入是否为 'y'
    if [ "$userInput" == "y" ]; then
    find ./ -name "*.wxapkg" -exec cp {} /sdcard/xcx/$userInputfile \;
    echo "[+]获取的wxapkg包如下:"
    ls /sdcard/xcx/$userInputfile
    echo ""
    echo "${GREEN}[*]进入工作目录->${RESET} cd /data/data/com.tencent.mm/MicroMsg&&find ./ -name *.wxapkg"
    echo "${GREEN}[*]电脑端运行命令->${RESET} adb pull /sdcard/xcx/$userInputfile"
    else
    echo "输入不是 'y'"
    fi
}

cha11_IOS(){
    echo "[*]请输入小程序的AppID:"
    read wxappid
    echo ""
    echo "[*]请输入小程序的名称:"
    read userInputfile
    mkdir -p ~/xcx/$userInputfile
    find /var/mobile/Containers/Data/Application/ -name "*.wxapkg" -print | while read -r file; do
        if [[ $file == *"$wxappid"* ]]; then
            cp "$file" ~/xcx/$userInputfile/
        fi
    done
    ls ~/xcx/$userInputfile
    echo ""
    # echo "[*]进入工作目录-> cd /data/data/com.tencent.mm/MicroMsg&&find ./ -name *.wxapkg"
    echo "[*]电脑端运行命令-> scp -r root@kios.local:~/xcx/$userInputfile ./"

}

# 获取 uname 命令的输出
uname_output=$(uname)

# 检查输出是否为 "Linux"
if [[ "$uname_output" == "Linux" ]]; then
    echo "${GREEN}[*]当前系统为安卓系统${RESET}"
    cha11_Android
elif [[ "$uname_output" == "Darwin" ]]; then
    echo "[*]当前系统为IOS系统"
    cha11_IOS
else
    echo "[+]未知系统，请修改脚本"
fi