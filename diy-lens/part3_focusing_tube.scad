// ============================================================
// 400mm DIY 镜头 - 零件 3：调焦内管
// 功能：在镜筒内前后滑动，微调物镜到传感器的距离以实现精确合焦
// 材料：PLA 黑色
// ============================================================

// 外径需小于 PVC 管内径（Φ90mm 管内径约 85mm）
slide_outer = 84.5;     // 外径（在管内滑动，留 0.5mm 间隙）
slide_inner = 76.0;     // 内径（通光）
slide_length = 60.0;    // 长度（调焦行程约 30mm）
wall_thickness = 4.25;  // 壁厚

// 锁紧螺丝参数
lock_screw_d = 3.0;     // 锁紧螺丝直径
lock_screw_count = 2;   // 锁紧螺丝数量

// 防转销（防止内管旋转，只允许前后移动）
anti_rotation_count = 2;
anti_rotation_width = 4.0;
anti_rotation_depth = 3.0;

$fn = 120;

module focusing_tube() {
    difference() {
        // 外圆柱
        cylinder(d=slide_outer, h=slide_length);

        // 内孔（通光）
        cylinder(d=slide_inner, h=slide_length + 0.1);

        // 锁紧螺丝孔（中部位置）
        for(i = [0:lock_screw_count - 1]) {
            rotate([0, 0, i * 180])
                translate([slide_outer / 2 + 0.5, 0, slide_length / 2])
                    rotate([0, 90, 0])
                        cylinder(d=lock_screw_d, h=wall_thickness + 1, center=true);
        }

        // 防转销槽（沿轴向的凹槽）
        for(i = [0:anti_rotation_count - 1]) {
            rotate([0, 0, i * 180 + 90])
                translate([slide_outer / 2, 0, slide_length / 2])
                    cube([anti_rotation_depth + 1, anti_rotation_width, slide_length - 10], center=true);
        }
    }
}

focusing_tube();
