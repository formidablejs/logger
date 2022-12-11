import { env } from '@formidablejs/framework'

export default {
	# --------------------------------------------------------------------------
	#  Default Log Channel
	# --------------------------------------------------------------------------
	#
	# This option defines the default log channel that gets used when writing
	# messages to the logs. The name specified in this option should match
	# one of the channels defined in the "channels" configuration array.

	default: env('LOG_CHANNEL', 'daily')

	# --------------------------------------------------------------------------
	#  Log Mode
	# --------------------------------------------------------------------------
	#
	# This option defines the log mode that Livy should use. Livy allows
	# handlers to implement both a synchronous and an asynchronous way to do
	# their jobs and tries to invoke them appropriately. However, since
	# Node.js is an inherently concurrent environment, there are cases where
	# a synchronous way is simply not available (especially for anything
	# network-related).
	#
	# Supported modes: "async", "sync"

	mode: env('LOG_MODE', 'async')

	# --------------------------------------------------------------------------
	#  Log Channels
	# --------------------------------------------------------------------------
	#
	# Here you may configure the log channels for your application. Out of
	# the box, Formidable uses the Livy JavaScript logging library. This gives
	# you a variety of powerful log handlers / formatters to utilize.
	#
	# Available Drivers: "console", "single", "daily"

	channels: {
		console: {
			driver: 'console'
			level: env('LOG_LEVEL', 'debug')
		}

		single: {
			driver: 'single'
			path: 'storage/logs/formidable.log'
			level: env('LOG_LEVEL', 'debug')
		}

		daily: {
			driver: 'daily'
			path: 'storage/logs/formidable.log'
			level: env('LOG_LEVEL', 'debug')
			days: 14
		}
	}
}
