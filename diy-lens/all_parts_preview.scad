// ============================================================
// 400mm DIY 镜头 - 全部零件预览
// 使用方法：在 OpenSCAD 中打开此文件，可以同时预览所有零件
// 按 F5 预览，按 F6 渲染，文件 → 导出 → STL
// ============================================================

$fn = 120;

// --- 零件 1：物镜压环 ---
module part1_lens_ring() {
    outer_diameter = 89.0;
    inner_diameter = 76.0;
    thickness = 8.0;
    lip_height = 2.0;
    lip_inner = 80.5;

    difference() {
        cylinder(d=outer_diameter, h=thickness);
        translate([0, 0, lip_height])
            cylinder(d=inner_diameter, h=thickness - lip_height + 0.1);
        cylinder(d=lip_inner, h=lip_height + 0.1);
        for(i = [0:3]) {
            rotate([0, 0, i * 90])
                translate([outer_diameter/2 - 4, 0, thickness/2])
                    rotate([0, 90, 0])
                        cylinder(d=3, h=8, center=true);
        }
    }
}

// --- 零件 2：L 卡口转接座 ---
module part2_l_mount_adapter() {
    tube_outer = 89.0;
    tube_inner = 76.0;
    mount_outer = 51.6;
    mount_inner = 44.0;
    adapter_length = 20.0;
    ear_count = 3;
    ear_width = 8.0;
    ear_height = 3.0;
    ear_radius = mount_outer / 2 + ear_height;
    pin_count = 3;
    pin_diameter = 3.5;

    difference() {
        union() {
            translate([0, 0, 0])
                cylinder(d=tube_outer, h=adapter_length / 2);
            translate([0, 0, adapter_length / 2])
                cylinder(d=mount_outer + 2, h=adapter_length / 2);
            for(i = [0:ear_count - 1]) {
                rotate([0, 0, i * (360 / ear_count) + 15])
                    translate([ear_radius * cos(0), ear_radius * sin(0), adapter_length - ear_height])
                        cube([ear_width, 6, ear_height], center=true);
            }
            translate([0, 0, adapter_length - 2])
                cylinder(d=mount_outer + 4, h=2);
        }
        cylinder(d=tube_inner, h=adapter_length / 2 + 0.1);
        translate([0, 0, adapter_length / 2])
            cylinder(d=mount_inner, h=adapter_length / 2 + 0.1);
        for(i = [0:ear_count - 1]) {
            rotate([0, 0, i * (360 / ear_count) + 15])
                translate([mount_outer / 2 + 2, 0, adapter_length - ear_height - 0.5])
                    cube([12, 8, ear_height + 1], center=true);
        }
        for(i = [0:pin_count - 1]) {
            rotate([0, 0, i * (360 / pin_count)])
                translate([tube_outer / 2 - 4, 0, 3])
                    rotate([0, 90, 0])
                        cylinder(d=pin_diameter, h=10, center=true);
        }
    }
}

// --- 零件 3：调焦内管 ---
module part3_focusing_tube() {
    slide_outer = 84.5;
    slide_inner = 76.0;
    slide_length = 60.0;
    wall_thickness = 4.25;
    lock_screw_d = 3.0;
    lock_screw_count = 2;
    anti_rotation_count = 2;
    anti_rotation_width = 4.0;
    anti_rotation_depth = 3.0;

    difference() {
        cylinder(d=slide_outer, h=slide_length);
        cylinder(d=slide_inner, h=slide_length + 0.1);
        for(i = [0:lock_screw_count - 1]) {
            rotate([0, 0, i * 180])
                translate([slide_outer / 2 + 0.5, 0, slide_length / 2])
                    rotate([0, 90, 0])
                        cylinder(d=lock_screw_d, h=wall_thickness + 1, center=true);
        }
        for(i = [0:anti_rotation_count - 1]) {
            rotate([0, 0, i * 180 + 90])
                translate([slide_outer / 2, 0, slide_length / 2])
                    cube([anti_rotation_depth + 1, anti_rotation_width, slide_length - 10], center=true);
        }
    }
}

// --- 并排展示所有零件 ---
translate([0, 0, 0])
    part1_lens_ring();

translate([0, 30, 0])
    part2_l_mount_adapter();

translate([0, 70, 0])
    part3_focusing_tube();
