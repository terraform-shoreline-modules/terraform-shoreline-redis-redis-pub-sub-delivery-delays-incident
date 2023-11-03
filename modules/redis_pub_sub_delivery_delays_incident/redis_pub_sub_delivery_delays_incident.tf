resource "shoreline_notebook" "redis_pub_sub_delivery_delays_incident" {
  name       = "redis_pub_sub_delivery_delays_incident"
  data       = file("${path.module}/data/redis_pub_sub_delivery_delays_incident.json")
  depends_on = [shoreline_action.invoke_update_redis_conf]
}

resource "shoreline_file" "update_redis_conf" {
  name             = "update_redis_conf"
  input_file       = "${path.module}/data/update_redis_conf.sh"
  md5              = filemd5("${path.module}/data/update_redis_conf.sh")
  description      = "Ensure that Redis is properly configured and tuned for optimal performance. This includes setting appropriate timeouts, buffer sizes, and other configuration parameters."
  destination_path = "/tmp/update_redis_conf.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_update_redis_conf" {
  name        = "invoke_update_redis_conf"
  description = "Ensure that Redis is properly configured and tuned for optimal performance. This includes setting appropriate timeouts, buffer sizes, and other configuration parameters."
  command     = "`chmod +x /tmp/update_redis_conf.sh && /tmp/update_redis_conf.sh`"
  params      = ["REDIS_TIMEOUT_VALUE","REDIS_BUFFER_SIZE_VALUE"]
  file_deps   = ["update_redis_conf"]
  enabled     = true
  depends_on  = [shoreline_file.update_redis_conf]
}

