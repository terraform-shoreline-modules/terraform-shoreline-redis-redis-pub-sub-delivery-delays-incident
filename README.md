
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Redis Pub/Sub delivery delays incident.
---

This incident type relates to the Redis Pub/Sub system, which is responsible for delivering messages between different systems. When this system experiences delays in delivery, it can cause disruptions in the communication between systems and slow down processes that rely on real-time data exchange. This can lead to issues such as data loss, missed deadlines, and reduced efficiency. The incident requires immediate attention to restore the system's normal functionality and mitigate any negative impact on the affected systems.

### Parameters
```shell
export CHANNEL_NAME="PLACEHOLDER"

export REDIS_TIMEOUT_VALUE="PLACEHOLDER"

export REDIS_BUFFER_SIZE_VALUE="PLACEHOLDER"
```

## Debug

### Check Redis server status
```shell
redis-cli ping
```

### List all Redis channels
```shell
redis-cli channels
```

### Check Redis subscriber count for a particular channel
```shell
redis-cli pubsub numsub ${CHANNEL_NAME}
```

### Check Redis subscriber list for a particular channel
```shell
redis-cli pubsub channels ${CHANNEL_NAME}
```

### Check Redis messages queued for a particular channel
```shell
redis-cli llen ${CHANNEL_NAME}
```

### Monitor Redis messages in real-time for a particular channel
```shell
redis-cli monitor | grep ${CHANNEL_NAME}
```

## Repair

### Ensure that Redis is properly configured and tuned for optimal performance. This includes setting appropriate timeouts, buffer sizes, and other configuration parameters.
```shell


#!/bin/bash



# Set Redis configuration parameters

redis_config_file="/etc/redis/redis.conf"

redis_timeout="${REDIS_TIMEOUT_VALUE}"

redis_buffer_size="${REDIS_BUFFER_SIZE_VALUE}"



# Update Redis configuration file with new parameters

sed -i "s/^timeout .*/timeout $redis_timeout/" $redis_config_file

sed -i "s/^tcp-backlog .*/tcp-backlog $redis_buffer_size/" $redis_config_file



# Restart Redis service

service redis restart


```