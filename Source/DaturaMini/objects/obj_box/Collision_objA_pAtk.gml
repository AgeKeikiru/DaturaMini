if(!other.hazard && !open && other.dmg > 0){
	
	open = true;
	
	shakeCam(random_range(-1, 1), random_range(-1, 1));
	
	onHit();
	
}