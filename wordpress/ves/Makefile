#all: namespace, pool, lb

namespace:
	vesctl configuration create namespace lk-wordpress

pool:
	vesctl configuration apply origin_pool -i ./lk-wordpress-pool.yml

lb:
	vesctl configuration apply http_loadbalancer -i ./lk-wordpress-lb.yml

tcp-lk:
	vesctl configuration apply tcp_loadbalancer -i ./lk-wordpress-tcp-lb.yml

delete:
	vesctl configuration delete http_loadbalancer lk-wordpress -n lk-wordpress
	vesctl configuration delete origin_pool lk-wordpress-pool -n lk-wordpress
