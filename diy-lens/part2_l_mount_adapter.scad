// ============================================================
// 400mm DIY 镜头 - 零件 2：L 卡口转接座
// 功能：连接镜筒后端到松下 S9（L 卡口）
// 材料：ABS 黑色（推荐，更耐久）
// ============================================================

// --- 镜筒端（大端） ---
tube_outer = 89.0;      // 外径（插入 Φ90mm PVC 管）
tube_inner = 76.0;      // 内径（通光）

// --- L 卡口端（小端）---
// L 卡口标准参数（松下/徕卡/适马 L 卡口）
mount_outer = 51.6;     // 卡口外径
mount_inner = 44.0;     // 卡口内径（全画幅对角线 43.3mm）
flange_distance = 20.0; // 法兰距（卡口面到传感器距离）
adapter_length = 20.0;  // 转接座总长

// --- 卡口固定凸耳 ---
ear_count = 3;          // L 卡口 3 个凸耳
ear_width = 8.0;        // 凸耳宽度
ear_height = 3.0;       // 凸耳高度
ear_radius = mount_outer / 2 + ear_height;

// --- 3 个定位螺丝孔 ---
pin_count = 3;
pin_diameter = 3.5;

$fn = 120;

module l_mount_adapter() {
    difference() {
        union() {
            // 镜筒连接端（锥形过渡）
            translate([0, 0, 0])
                cylinder(d=tube_outer, h=adapter_length / 2);

            // L 卡口端
            translate([0, 0, adapter_length / 2])
                cylinder(d=mount_outer + 2, h=adapter_length / 2);

            // L 卡口凸耳（3 个）
            for(i = [0:ear_count - 1]) {
                rotate([0, 0, i * (360 / ear_count) + 15])
                    translate([ear_radius * cos(0), ear_radius * sin(0), adapter_length - ear_height])
                        cube([ear_width, 6, ear_height], center=true);
            }

            // 卡口定位环（对准传感器法兰面）
            translate([0, 0, adapter_length - 2])
                cylinder(d=mount_outer + 4, h=2);
        }

        // 通光孔（两段不同直径）
        cylinder(d=tube_inner, h=adapter_length / 2 + 0.1);
        translate([0, 0, adapter_length / 2])
            cylinder(d=mount_inner, h=adapter_length / 2 + 0.1);

        // L 卡口凸耳内侧切口（配合相机卡口槽）
        for(i = [0:ear_count - 1]) {
            rotate([0, 0, i * (360 / ear_count) + 15])
                translate([mount_outer / 2 + 2, 0, adapter_length - ear_height - 0.5])
                    cube([12, 8, ear_height + 1], center=true);
        }

        // 定位螺丝孔
        for(i = [0:pin_count - 1]) {
            rotate([0, 0, i * (360 / pin_count)])
                translate([tube_outer / 2 - 4, 0, 3])
                    rotate([0, 90, 0])
                        cylinder(d=pin_diameter, h=10, center=true);
        }
    }
}

l_mount_adapter();
