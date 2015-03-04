
const broker_port: port &redef;
redef exit_only_after_terminate = T;
redef Comm::endpoint_name = "listener";
global msg_count = 0;
global my_event: event(msg: string, c: count);
global my_auto_event: event(msg: string, c: count);

event bro_init()
	{
	Comm::enable();
	Comm::subscribe_to_events("bro/event/");
	Comm::listen(broker_port, "127.0.0.1");
	}

event Comm::incoming_connection_established(peer_name: string)
	{
	print "Comm::incoming_connection_established", peer_name;
	}

event my_event(msg: string, c: count)
	{
	++msg_count;
	print "got my_event", msg, c;

	if ( msg_count == 5 )
		terminate();
	}

event my_auto_event(msg: string, c: count)
	{
	++msg_count;
	print "got my_auto_event", msg, c;

	if ( msg_count == 5 )
		terminate();
	}
