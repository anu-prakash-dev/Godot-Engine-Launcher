extends Node


var data = [{"a1":"1.1",
 "lb1":"https://downloads.tuxfamily.org/godotengine/1.1/Godot_v1.1_stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/1.1/Godot_v1.1_stable_win64.exe.zip",
 "mb1":""
}, {"a1":"2.0",
 "lb1":"https://downloads.tuxfamily.org/godotengine/2.0/Godot_v2.0_stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/2.0/Godot_v2.0_stable_win64.exe.zip",
 "mb1":""
}, {
	"a1":"2.0.1",
	"lb1":"https://downloads.tuxfamily.org/godotengine/2.0.1/Godot_v2.0.1_stable_x11.64.zip",
	"wb1":"https://downloads.tuxfamily.org/godotengine/2.0.1/Godot_v2.0.1_stable_win64.exe.zip",
	"mb1":""
}, {
	"a1":"2.0.2",
	"lb1":"https://downloads.tuxfamily.org/godotengine/2.0.2/Godot_v2.0.2_stable_x11.64.zip",
	"wb1":"https://downloads.tuxfamily.org/godotengine/2.0.2/Godot_v2.0.2_stable_win64.exe.zip",
	"mb1":""
}, {
	"a1":"2.0.3",
	"lb1":"https://downloads.tuxfamily.org/godotengine/2.0.3/Godot_v2.0.3_stable_x11.64.zip",
	"wb1":"https://downloads.tuxfamily.org/godotengine/2.0.3/Godot_v2.0.3_stable_win64.exe.zip",
	"mb1":"https://downloads.tuxfamily.org/godotengine/2.0.3/Godot_v2.0.3_stable_osx64.zip"
}, {
	"a1":"2.0.4.1",
	"lb1":"https://downloads.tuxfamily.org/godotengine/2.0.4.1/Godot_v2.0.4.1_stable_x11.64.zip",
	"wb1":"https://downloads.tuxfamily.org/godotengine/2.0.4.1/Godot_v2.0.4.1_stable_win64.exe.zip",
	"mb1":""
}, {"a1":"2.1",
 "lb1":"https://downloads.tuxfamily.org/godotengine/2.1/Godot_v2.1-stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/2.1/Godot_v2.1-stable_win64.exe.zip",
 "mb1":""
}, {
	"a1":"2.1.1",
	"lb1":"https://downloads.tuxfamily.org/godotengine/2.1.1/Godot_v2.1.1-stable_x11.64.zip",
	"wb1":"https://downloads.tuxfamily.org/godotengine/2.1.1/Godot_v2.1.1-stable_win64.exe.zip",
	"mb1":""
}, {
	"a1":"2.1.2",
	"lb1":"https://downloads.tuxfamily.org/godotengine/2.1.2/Godot_v2.1.2-stable_x11.64.zip",
	"wb1":"https://downloads.tuxfamily.org/godotengine/2.1.2/Godot_v2.1.2-stable_win64.exe.zip",
	"mb1":""
}, {
	"a1":"2.1.3",
	"lb1":"https://downloads.tuxfamily.org/godotengine/2.1.3/Godot_v2.1.3-stable_x11.64.zip",
	"wb1":"https://downloads.tuxfamily.org/godotengine/2.1.3/Godot_v2.1.3-stable_win64.exe.zip",
	"mb1":""
}, {
	"a1":"2.1.4",
	"lb1":"https://downloads.tuxfamily.org/godotengine/2.1.4/Godot_v2.1.4-stable_x11.64.zip",
	"wb1":"https://downloads.tuxfamily.org/godotengine/2.1.4/Godot_v2.1.4-stable_win64.exe.zip",
	"mb1":""
}, {
	"a1":"2.1.5",
	"lb1":"https://downloads.tuxfamily.org/godotengine/2.1.5/Godot_v2.1.5-stable_x11.64.zip",
	"wb1":"https://downloads.tuxfamily.org/godotengine/2.1.5/Godot_v2.1.5-stable_win64.exe.zip",
	"mb1":""
}, {
	"a1":"2.1.6",
	"lb1":"https://downloads.tuxfamily.org/godotengine/2.1.6/Godot_v2.1.6-stable_x11.64.zip",
	"wb1":"https://downloads.tuxfamily.org/godotengine/2.1.6/Godot_v2.1.6-stable_win64.exe.zip",
	"mb1":""
}, {"a1":"2.1.7",
 "lb1":"https://downloads.tuxfamily.org/godotengine/2.1.7/rc/20200815/Godot_v2.1.7-rc_20200815_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/2.1.7/rc/20200815/Godot_v2.1.7-rc_20200815_win64.exe.zip",
 "mb1":"https://downloads.tuxfamily.org/godotengine/2.1.7/rc/20200815/Godot_v2.1.7-rc_20200815_osx.64.zip"
}, {"a1":"3.0",
 "lb1":"https://downloads.tuxfamily.org/godotengine/3.0/Godot_v3.0-stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/3.0/Godot_v3.0-stable_win64.exe.zip", "mb1":""}, 
{
	"a1":"3.0.1",
	"lb1":"https://downloads.tuxfamily.org/godotengine/3.0.1/Godot_v3.0.1-stable_x11.64.zip",
	"wb1":"https://downloads.tuxfamily.org/godotengine/3.0.1/Godot_v3.0.1-stable_win64.exe.zip",
	"mb1":""
}, {
	"a1":"3.0.2",
	"lb1":"https://downloads.tuxfamily.org/godotengine/3.0.2/Godot_v3.0.2-stable_x11.64.zip",
	"wb1":"https://downloads.tuxfamily.org/godotengine/3.0.2/Godot_v3.0.2-stable_win64.exe.zip",
	"mb1":""
}, {
	"a1":"3.0.3",
	"lb1":"https://downloads.tuxfamily.org/godotengine/3.0.3/Godot_v3.0.3-stable_x11.64.zip",
	"wb1":"https://downloads.tuxfamily.org/godotengine/3.0.3/Godot_v3.0.3-stable_win64.exe.zip",
	"mb1":""
}, {
	"a1":"3.0.4",
	"lb1":"https://downloads.tuxfamily.org/godotengine/3.0.4/Godot_v3.0.4-stable_x11.64.zip",
	"wb1":"https://downloads.tuxfamily.org/godotengine/3.0.4/Godot_v3.0.4-stable_win64.exe.zip",
	"mb1":""
}, {
	"a1":"3.0.5",
	"lb1":"https://downloads.tuxfamily.org/godotengine/3.0.5/Godot_v3.0.5-stable_x11.64.zip",
	"wb1":"https://downloads.tuxfamily.org/godotengine/3.0.5/Godot_v3.0.5-stable_win64.exe.zip",
	"mb1":""
}, {
	"a1":"3.0.6",
	"lb1":"https://downloads.tuxfamily.org/godotengine/3.0.6/Godot_v3.0.6-stable_x11.64.zip",
	"wb1":"https://downloads.tuxfamily.org/godotengine/3.0.6/Godot_v3.0.6-stable_win64.exe.zip",
	"mb1":""
}, {
 "a1":"3.1",
 "lb1":"https://downloads.tuxfamily.org/godotengine/3.1/Godot_v3.1-stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/3.1/Godot_v3.1-stable_win64.exe.zip",
 "mb1":"https://downloads.tuxfamily.org/godotengine/3.1/Godot_v3.1-stable_osx.64.zip"}, {
	"a1":"3.1.1",
	"lb1":"https://downloads.tuxfamily.org/godotengine/3.1.1/Godot_v3.1.1-stable_x11.64.zip",
	"wb1":"https://downloads.tuxfamily.org/godotengine/3.1.1/Godot_v3.1.1-stable_win64.exe.zip",
	"mb1":"https://downloads.tuxfamily.org/godotengine/3.1.1/Godot_v3.1.1-stable_osx.64.zip"
}, {
	"a1":"3.1.2",
	"lb1":"https://downloads.tuxfamily.org/godotengine/3.1.2/Godot_v3.1.2-stable_x11.64.zip",
	"wb1":"https://downloads.tuxfamily.org/godotengine/3.1.2/Godot_v3.1.2-stable_win64.exe.zip",
	"mb1":"https://downloads.tuxfamily.org/godotengine/3.1.2/Godot_v3.1.2-stable_osx.64.zip"
}, {
 "a1":"3.2",
 "lb1":"https://downloads.tuxfamily.org/godotengine/3.2/Godot_v3.2-stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/3.2/Godot_v3.2-stable_win64.exe.zip",
 "mb1":"https://downloads.tuxfamily.org/godotengine/3.2/Godot_v3.2-stable_osx.64.zip"}, 
{
	"a1":"3.2.1",
	"lb1":"https://downloads.tuxfamily.org/godotengine/3.2.1/Godot_v3.2.1-stable_x11.64.zip",
	"wb1":"https://downloads.tuxfamily.org/godotengine/3.2.1/Godot_v3.2.1-stable_win64.exe.zip",
	"mb1":"https://downloads.tuxfamily.org/godotengine/3.2.1/Godot_v3.2.1-stable_osx.64.zip"
}, {
	"a1":"3.2.2",
	"lb1":"https://downloads.tuxfamily.org/godotengine/3.2.2/Godot_v3.2.2-stable_x11.64.zip",
	"wb1":"https://downloads.tuxfamily.org/godotengine/3.2.2/Godot_v3.2.2-stable_win64.exe.zip",
	"mb1":"https://downloads.tuxfamily.org/godotengine/3.2.2/Godot_v3.2.2-stable_osx.64.zip"
}, {
 "a1":"3.2.3",
 "lb1":"https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_win64.exe.zip",
 "mb1":"https://downloads.tuxfamily.org/godotengine/3.2.3/Godot_v3.2.3-stable_osx.64.zip"}, {
 "a1":"3.2.4 Beta 4",
 "lb1":"https://downloads.tuxfamily.org/godotengine/3.2.4/beta4/Godot_v3.2.4-beta4_x11.64.zip",
 "wb1":"https://downloads.tuxfamily.org/godotengine/3.2.4/beta4/Godot_v3.2.4-beta4_win64.exe.zip",
 "mb1":"https://downloads.tuxfamily.org/godotengine/3.2.4/beta4/Godot_v3.2.4-beta4_osx.universal.zip"
 }]
