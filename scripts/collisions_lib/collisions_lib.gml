/*
    A small library for collision lines with "thickness".  Static sensor objects
    are used and stretched to then call built-in collision functions.
 
    The object __collision_line_thick must be created and have a sprite with the following settings:
        width          = 1
        height         = 2
        origin         = middle left
        collision mask = full image, rectangle with rotation
                
    The object should also have persistent set to TRUE so that room changes will not cause the
    instance to be destroyed.
*/

/// @function                   collision_line_thick(_x1, _y1, _x2, _y2, _thickness, _object)
/// @param {real} _x1           The x coordinate of the start of the line
/// @param {real} _y1           The y coordinate of the start of the line
/// @param {real} _x2           The x coordinate of the end of the line
/// @param {real} _y2           The y coordinate of the end of the line
/// @param {real} _thickness    The thickness of the line to check for collisions
/// @param {index} _object      The object to check for instance collisions
/// @description                A thick collision line that returns the the first instance collided with
 
function collision_line_thick(_x1, _y1, _x2, _y2, _thickness, _object)
{
    static _sensor = instance_create_depth(0, 0, -16000, __collision_line_thick);
    
    with (_sensor)
    {
        x = _x1;
        y = _y1;
        image_xscale = point_distance(_x1, _y1, _x2, _y2);
        image_yscale = _thickness * 0.5;
        image_angle  = point_direction(_x1, _y1, _x2, _y2);
    
        return instance_place(x, y, _object);
    }
}
 
 
/// @function                   collision_line_thick_list(_x1, _y1, _x2, _y2, _thickness, _object, _list, _ordered)
/// @param {real} _x1           The x coordinate of the start of the line
/// @param {real} _y1           The y coordinate of the start of the line
/// @param {real} _x2           The x coordinate of the end of the line
/// @param {real} _y2           The y coordinate of the end of the line
/// @param {real} _thickness    The thickness of the line to check for collisions
/// @param {index} _object      The object to check for instance collisions
/// @param {index} _list        The DS list to use to store the IDs of the colliding instances
/// @param {boolean} _ordered   Whether the list should be ordered by distance (true) or not (false)
/// @description                A thick collision line that returns the number of instances collided with
 
function collision_line_thick_list(_x1, _y1, _x2, _y2, _thickness, _object, _list, _ordered)
{
    static _sensor = instance_create_depth(0, 0, -16000, __collision_line_thick);
    
    with (_sensor)
    {
        x = _x1;
        y = _y1;
        image_xscale = point_distance(_x1, _y1, _x2, _y2);
        image_yscale = _thickness * 0.5;
        image_angle  = point_direction(_x1, _y1, _x2, _y2);
 
        return instance_place_list(x, y, _object, _list, _ordered);
    }
}
 
 
/// @function                   collision_line_thick_impact(_x1, _y1, _x2, _y2, _thickness, _object)
/// @param {real} _x1           The x coordinate of the start of the line
/// @param {real} _y1           The y coordinate of the start of the line
/// @param {real} _x2           The x coordinate of the end of the line
/// @param {real} _y2           The y coordinate of the end of the line
/// @param {real} _thickness    The thickness of the line to check for collisions
/// @param {index} _object      The object to check for instance collisions
/// @description                A thick collision line that returns a struct with instance ID and impact x/y position
 
function collision_line_thick_impact(_x1, _y1, _x2, _y2, _thickness, _object)
{
    static _sensor = instance_create_depth(0, 0, -16000, __collision_line_thick);
    
    with (_sensor)
    {
        x = _x1;
        y = _y1;
        image_xscale = point_distance(_x1, _y1, _x2, _y2);
        image_yscale = _thickness * 0.5;
        image_angle  = point_direction(_x1, _y1, _x2, _y2);
    
        var _inst = instance_place(x, y, _object),
            _rx = _x1, 
            _ry = _y1;
                
        if (_inst != noone) {
                
            var _count = ceil(log2(image_xscale)) + 1,
                _p0 = 0,
                _p1 = 1;
            
            _x2 -= _x1;
            _y2 -= _y1;
        
            repeat (_count) {
            
                var _np = _p0 + (_p1 - _p0) * 0.5,
                    _nx = _x1 + _x2 * _np,
                    _ny = _y1 + _y2 * _np;
 
                    image_xscale = point_distance(x, y, _nx, _ny);
                    var _inst2   = instance_place(x, y, _object);
                
                if (_inst2 != noone) {
                    _inst = _inst2;
                    _rx = _nx;
                    _ry = _ny;
                    _p1 = _np;
                } else _p0 = _np;
            }
        }
    
        return { id : _inst, x : _rx, y : _ry };
    }
}