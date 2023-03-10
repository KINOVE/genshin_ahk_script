#Include point.ahk
#Include genshin.ahk

class Dispatch {
    static sleep_time := 200
    ;四个派遣区域
    static p_area_range_1 := Point(208, 165)
    static p_area_range_2 := Point(208, 237)
    static p_area_range_3 := Point(208, 309)
    static p_area_range_4 := Point(208, 382)
    ;四个派遣区域的六个点位
    static p_characters_1 := [Point(883,414), Point(1135,248), Point(1375,338), Point(1439,455), Point(1063,538), Point(1495,662)]
    static p_characters_2 := [Point(883,572), Point(1047,332), Point(1283,456), Point(1131,563), Point(1493,619), Point(1051,822)]
    static p_characters_3 := [Point(1420,283),Point(1257,350), Point(1467,441), Point(1046,700), Point(906,809), Point(1150,834)]
    static p_characters_4 := [Point(1374,248),Point(1117,301), Point(1280,380), Point(1221,563), Point(1350,616), Point(1000,643)]
    ;派遣检查
    static p_favourable := [Point(1200,362), Point(1200,257), Point(1200,151)]

    ;按钮信息
    static p_button_pos := Point(2170,1021)
    static color_dis := '0xFE5C5C'
    static color_yes := '0x99CC33'
    static color_ready := '0x313131'
    static color_in_yes := '0x99ff22'
    static refresh_pos() {
        size := Genshin.get_game_pos()
        width := size[1]
        height := size[2]
        ;刷新点位坐标
        this.p_area_range_1.refresh_pos(width, height)
        this.p_area_range_2.refresh_pos(width, height)
        this.p_area_range_3.refresh_pos(width, height)
        this.p_area_range_4.refresh_pos(width, height)
        this.p_button_pos.refresh_pos(width, height)
        for i in this.p_characters_1 {
            i.refresh_pos(width, height)
        }
        for i in this.p_characters_2 {
            i.refresh_pos(width, height)
        }
        for i in this.p_characters_3 {
            i.refresh_pos(width, height)
        }
        for i in this.p_characters_4 {
            i.refresh_pos(width, height)
        }
        for i in this.p_favourable {
            i.refresh_pos(width, height)
        }
    }

    static sendpatch() {
        ;等待界面打开
        Sleep(200)
        if PixelGetColor(this.p_favourable[1].x, this.p_favourable[1].y) = this.color_in_yes {
            MouseClick(,this.p_favourable[1].x, this.p_favourable[1].y,,0)
        }
        if PixelGetColor(this.p_favourable[2].x, this.p_favourable[2].y) = this.color_in_yes {
            Sleep(100)
            MouseClick(,this.p_favourable[2].x, this.p_favourable[2].y,,0)
        }
        if PixelGetColor(this.p_favourable[3].x, this.p_favourable[3].y) = this.color_in_yes {
            Sleep(100)
            MouseClick(,this.p_favourable[3].x, this.p_favourable[3].y,,0)
        }
        Sleep(200)
    }
    
    static checkifpatch() {
        Sleep(50)
        if (PixelGetColor(this.p_button_pos.x, this.p_button_pos.y) = this.color_yes) {
            MouseClick(,this.p_button_pos.x, this.p_button_pos.y,,0)
            Sleep(this.sleep_time)
            MouseClick(,this.p_button_pos.x, this.p_button_pos.y,,0)
            Sleep(this.sleep_time)
            MouseClick(,this.p_button_pos.x, this.p_button_pos.y,,0)
            Sleep(this.sleep_time)
            this.sendpatch()
        }
        else if (PixelGetColor(this.p_button_pos.x, this.p_button_pos.y) = this.color_ready) {
            MouseClick(,this.p_button_pos.x, this.p_button_pos.y,,0)
            Sleep(this.sleep_time)
            this.sendpatch()
        }
    }

    static dispatch() {
        this.refresh_pos()
        ;点击第2区域
        MouseClick(,this.p_area_range_2.x,this.p_area_range_2.y,,0)
            MouseClick(,this.p_characters_2[1].x,this.p_characters_2[1].y,,0) 
            this.checkifpatch()
            MouseClick(,this.p_characters_2[4].x,this.p_characters_2[4].y,,0)
            this.checkifpatch()
            MouseClick(,this.p_characters_2[3].x,this.p_characters_2[3].y,,0)
            this.checkifpatch()
        ;点击第3区域
        MouseClick(,this.p_area_range_3.x,this.p_area_range_3.y,,0)
            MouseClick(,this.p_characters_3[6].x,this.p_characters_3[6].y,,0)
            this.checkifpatch()
        ;点击第4区域
        MouseClick(,this.p_area_range_4.x,this.p_area_range_4.y,,0)
            MouseClick(,this.p_characters_4[3].x,this.p_characters_4[3].y,,0)
            this.checkifpatch()
        ;退出
        SendInput("{Esc}")
    }
}
