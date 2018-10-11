import datetime
import dateutil

CONTAINER_MAX_CPU = 512
CONTAINER_MAX_MEM = 1024

def lambda_handler(event, context):
    cluster = event["ECS_CLUSTER"]
    print('Calculating schedulable containers for cluster %s' % cluster)
    instance_list = ecs.list_container_instances(cluster=cluster, status='ACTIVE')
    instances = ecs.describe_container_instances(cluster=cluster,
                                                 containerInstances=instance_list['containerInstanceArns'])

    schedulable_containers = 0

    for instance in instances['containerInstances']:
        remaining_resources = {resource['name']: resource for resource in instance['remainingResources']}

        containers_by_cpu = int(remaining_resources['CPU']['integerValue'] / CONTAINER_MAX_CPU)
        containers_by_mem = int(remaining_resources['MEMORY']['integerValue'] / CONTAINER_MAX_MEM)

        schedulable_containers += min(containers_by_cpu, containers_by_mem)

        print('%s containers could be scheduled on %s based on CPU only' % (containers_by_cpu, instance['ec2InstanceId']))
        print('%s containers could be scheduled on %s based on memory only' % (containers_by_mem, instance['ec2InstanceId']))

    print('Schedulable containers: %s' % schedulable_containers)

    cw.put_metric_data(Namespace='ECSScalingMetrics',
                       MetricData=[{
                           'MetricName': 'SchedulableContainers',
                           'Dimensions': [{
                               'Name': 'ClusterName',
                               'Value': cluster
                           }],
                           'Timestamp': datetime.datetime.now(dateutil.tz.tzlocal()),
                           'Value': schedulable_containers
                       }])

    print('Metric is sent to CloudWatch')
    return {}