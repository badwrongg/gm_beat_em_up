event_inherited();

prop_collider = instance_create_layer(x, y, layer, __collider_all);
prop_collider.mask_index   = mask_index;
prop_collider.sprite_index = mask_index;
x_draw = x;
y_draw = y;