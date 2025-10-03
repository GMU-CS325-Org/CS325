class_name BulletVolleyGroup extends Object

var bullet_volleys : Array[BulletVolley]

func add_volley(volley : BulletVolley) -> void:
	bullet_volleys.append(volley)

func fire() -> void:
	for volley in bullet_volleys:
		volley.fire()
