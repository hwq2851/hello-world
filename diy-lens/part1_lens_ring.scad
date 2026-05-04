// ============================================================
// 400mm DIY 镜头 - 零件 1：物镜压环
// 功能：固定 80mm 双合透镜到 Φ90mm PVC 管前端
// 材料：PLA 黑色
// ============================================================

outer_diameter = 89.0;   // 外径（过盈配合 Φ90mm 管内壁）
inner_diameter = 76.0;   // 内径（露出 80mm 镜片通光，留 2mm 压边）
thickness = 8.0;         // 厚度
lip_height = 2.0;        // 压边高度（压住镜片边缘）
lip_inner = 80.5;        // 压边内径（比镜片大 0.5mm）

$fn = 120;  // 圆度（越高越光滑，打印时够用）

difference() {
    // 外圆柱体
    cylinder(d=outer_diameter, h=thickness);

    // 内孔
    translate([0, 0, lip_height])
        cylinder(d=inner_diameter, h=thickness - lip_height + 0.1);

    // 压边台阶
    cylinder(d=lip_inner, h=lip_height + 0.1);

    // 四个螺丝孔（用于锁紧到 PVC 管）
    for(i = [0:3]) {
        rotate([0, 0, i * 90])
            translate([outer_diameter/2 - 4, 0, thickness/2])
                rotate([0, 90, 0])
                    cylinder(d=3, h=8, center=true);
    }
}
