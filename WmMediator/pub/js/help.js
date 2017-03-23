function help_fun(a) 
{
var result=" ";
var help=[
{key:"pg.3pSnmpSender.sendDelay",value:"This is an internal parameter. Do not modify."},
{key:"pg.CollectionPool.forcefulShutdown",value:"Specifies whether the data collection thread pool should shut down immediately or wait for queued tasks to complete during Mediator shutdown. The default is false."},
{key:"pg.CollectionPool.maxThreads",value:"The maximum number of threads to be used for data collection (metrics and events). This value must be greater than or equal to the value of pg.CollectionPool.minThreads. The default is 8."},
{key:"pg.CollectionPool.minThreads",value:"The minimum number of threads to be used for data collection (metrics and events).Specifying more threads means that Mediator can collect more data faster, but it will also increase the usage of system resources, which could result in slower service execution. The default is 1."},
{key:"pg.CollectionPool.poolName",value:"Sets the name for the data collection thread pool. The default is CollectionPool."},
{key:"pg.CollectionWorkQueue.queueCapacity",value:"The size of the collection work queue to be used during data collection (metrics and events). This queue is used only when there are not enough collection pool threads to process all the data. For example, if pg.CollectionPool.maxThreads is set to 10, and the 10 threads are not sufficient for processing all the data, then the unprocessed data will be put into the collection work queue. If the queue capacity is reached, then any additional data will be lost. The default is 10000 items of data allowed in the queue.Specifying a large queue and a small collection pool minimizes CPU usage and operating system resources, but this can lead to low throughput which will cause delays in data collection. Using a small collection work queue generally requires larger collection pool sizes, which keeps CPUs busier. This will avoid the delay but may encounter unacceptable scheduling overhead, which also decreases service execution."},
{key:"pg.IntervalPool.forcefulShutdown",value:"Specifies whether the interval thread pool should wait for queued tasks to complete during Mediator shutdown. Se?ing this parameter to true will cause Mediator to shutdown immediately, without waiting for the tasks to finish. The default is false."},
{key:"pg.IntervalPool.maxThreads",value:"Specifies the maximum thread count for this interval pool. The default is 1."},
{key:"pg.IntervalPool.minThreads",value:"Specifies the minimum thread count for this interval pool. The default is 1."},
{key:"pg.IntervalPool.poolName",value:"Specifies the name of the interval processor pool. The default is IntervalPool."},
{key:"pg.PgMenConfiguration.sieFlushInterval",value:"Specifies the number of seconds before the accumulated invoked service events are pushed into the shared cache. The default is 2."},
{key:"pg.PgMenConfiguration.sieFlushThreshold",value:"No Description is available"},
{key:"pg.PgMenConfiguration.tickInterval",value:"Specifies the amount of time (in seconds) between each interval processor iteration. This must be an evenly divisible fraction of the smallest policy interval, which is one minute.The default is 15."},
{key:"pg.PgMenSharedCacheManager.lockRetry",value:"No Description is available"},
{key:"pg.PgMenSharedCacheManager.lockTimeOut",value:"Specifies the amount of time (in seconds) the shared cache waits to obtain a lock before timing out. The default is 5."},
{key:"pg.PgMetricsFormatter.includeFaults",value:"Specifies whether service faults are included in the aggregated performance metrics.If set to true, the average, minimum, and maximum response times will include failed requests in the calculations. The default is false."},
{key:"pg.ReportingPool.forcefulShutdown",value:"Specifies whether the reporting pool should wait for queued tasks to complete during Mediator shutdown. Seeing this parameter to true will cause Mediator to shut down immediately, without waiting for the tasks to finish. The default is true."},
{key:"pg.ReportingPool.maxThreads",value:"The maximum number of threads to be used for data reporting (metrics and events).This value must be greater than or equal to the value of pg.ReportingPool.minThreads. The default is 4."},
{key:"pg.ReportingPool.minThreads",value:"The minimum number of threads to be used for data reporting (metrics and events).Specifying more threads means that Mediator can send more events to the event destination faster, but it will also increase the usage of system resources, which could result in slower service execution. The default is 2."},
{key:"pg.ReportingPool.poolName",value:"Specifies the name of the reporting pool. The default is ReportingPool."},
{key:"pg.ReportingWorkQueue.queueCapacity",value:"The size of the reporting work queue to be used during data reporting (metrics and events). This queue is used only when there are not enough reporting pool threads to process all the data to be reported. For example, if pg.ReportingPool.maxThreads is set to 10, and the 10 threads are not sufficient for processing all the data, then the unprocessed data will be put into the reporting work queue. If the queue capacity is reached, then any additional data will be lost. The default is 5000 items of data allowed in the queue.Specifying a large queue and a small reporting pool minimizes CPU usage and operating system resources, but this can lead to low throughput which will cause delays in data reporting. Using a small reporting work queue generally requires larger reporting pool sizes, which keeps CPUs busier. This will avoid the delay but may encounter unacceptable scheduling overhead, which also decreases service execution."},
{key:"pg.aliasServiceAssociation.delayedLoader.count",value:"No Description is available"},
{key:"pg.aliasServiceAssociation.delayedLoader.sleepTime",value:"No Description is available"},
{key:"pg.apikey.header",value:"No Description is available"},
{key:"pg.apikey.removeParameter",value:"No Description is available"},
{key:"pg.csSnmpSender.sendDelay",value:"This is an internal parameter. Do not modify."},
{key:"pg.debug.eventLoggerActive",value:"This is an internal parameter. Do not modify."},
{key:"pg.delayedRefresher.napMillis",value:"Specifies the amount of time (in milliseconds) the delayed refresher helper waits before checking to see whether Integration Server is running. The default is 500."},
{key:"pg.email.charSet",value:"Specifies the character set to use for the subject line, email addresses, and message body of the emails when sending alerts or events. The default is US-ASCII."},
{key:"pg.email.debug",value:"This is an internal parameter. Do not modify."},
{key:"pg.email.resourceMimeType",value:"Specifies the MIME type Mediator uses to send the request and response payload attachments for transaction events that are sent by email. Mediator supports the following values:application/gzip (.gz),application/zip (.zip),text/xml (.xml) The default is application/gzip."},
{key:"pg.email.timeOut",value:"Specifies the time out period (in milliseconds) when connecting to an e-mail server and sending e-mails. The default is 1000."},
{key:"pg.endpoint.connectionTimeout",value:"Specifies the time interval (in seconds) after which an HTTP connection a?empt will timeout. Default: 30 seconds.This is a global property that applies to the endpoints of all virtual services. If you prefer to specify a connection timeout for the endpoints of virtual services individually, set the HTTP Connection Timeout parameter in the virtual service's Routing Protocols processing step. This parameter takes precedence over pg.endpoint.connectionTimeout."},
{key:"pg.endpoint.readTimeout",value:"Specifies the time interval (in seconds) after which a socket read attempt will timeout.Default: 30 seconds.This is a global property that applies to all virtual services. If you prefer to specify a read timeout for virtual services individually, set the Read Timeout parameter in the virtual service's Routing Protocols processing step. This parameter takes precedence over pg.endpoint.readTimeout."},
{key:"pg.http.listener",value:"No Description is available"},
{key:"pg.lb.failoverOnDowntimeErrorOnly",value:"Controls Mediator's behavior for load-balanced endpoints. The default is false, which means that in a load-balanced routing scenario, if a service fault is encountered in the response coming from endpoint 1, then Mediator will immediately try the next configured endpoint. There is no distinction on the type of fault present in the response from endpoint 1.However, if this parameter is set to true, then Mediator will fail over only if the service fault is a downtime error (that is, if it matches one of the strings defined in the file: Integration Server_directory\instances\instance_name\packages\WmMediator\config\resources\downtime-patterns.txt"},
{key:"pg.nerv.PgMenConfiguration.cache.size",value:"Denotes the number of entries (events) that NERV will keep in the cache when trying to publish events to the EDA Destination. Default: 2000."},
{key:"pg.nerv.muticast.stoponexception",value:"No Description is available"},
{key:"pg.oauth2.isHTTPS",value:"Specifies the transport protocol over which the OAuth2 access tokens will be granted authorization. Set this parameter to true for HTTPS (the default) or false for HTTP"},
{key:"pg.oauth2.ports",value:"If pg.oauth2.isHTTPS is set to true, specify a comma-separated list of the HTTPS ports on which the service pub.mediator.oauth2.getOAuth2AccessToken will be available."},
{key:"pg.policygateway.deploy.receiver.deleteTempArtifacts",value:"No Description is available"},
{key:"pg.rampart.response.timetolive",value:"No Description is available"},
{key:"pg.rest.json.use.cache",value:"No Description is available"},
{key:"pg.rest.use.default.contentType",value:"No Description is available"},
{key:"pg.uddiClient.publish.maxThreads",value:"No Description is available"},
{key:"pg.uddiClient.uddiClientTimeout",value:"Specifies the number of milliseconds that can elapse before not publishing performance metrics to an unavailable CentraSite server. The default is 5000."}

];

for (var i = 0; i < help.length; i++){
	if(help[i].key == a){
		result=help[i].value;
		break;
	}
	
}


return result;   
}




