import { Log } from './Logger'
import type { LogLevel } from '@livy/contracts'
import type { LogRecordContext } from '@livy/contracts'

# Log with debug level
def debug message\string, context\LogRecordContext = null
	Log.debug(message, context)

# Log with info level
def info message\string, context\LogRecordContext = null
	Log.info(message, context)

# Log with an arbitrary level
def log level\LogLevel, message\string, context\LogRecordContext = null
	Log.log(level, message, context)

export {
	debug
	info
	log
}
