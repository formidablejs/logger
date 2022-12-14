import { config } from '@formidablejs/framework'
import { createLogger } from '@livy/logger'
import { InvalidLogDriverException } from './Exceptions/InvalidLogDriverException'
import { RegisteredLogDriverException } from './Exceptions/RegisteredLogDriverException'
import type { LogLevel } from '@livy/contracts'
import type { LogRecordContext } from '@livy/contracts'
import type { LoggerInterface } from '@livy/contracts'

# Registered channels
const registered = {}

# Available logger instances
const available = {}

# Register driver
def register\void name\string, driver\Driver 
	if registered[name]
		throw new RegisteredLogDriverException "Driver \"{name}\" is already registered"

	registered[name] = driver

# Get driver
def get name\string
	if !registered[name]
		throw new InvalidLogDriverException "Driver \"{name}\" is not registered"

	registered[name]

def getInstance name\string
	if !available[name]
		throw new Error 'Invalid instance'

	available[name]

def registerInstance name\string, handler
	available[name] = handler

let environment\string = 'local'
let loggingMode\string = 'sync'

try
	environment = config('app.env', 'local')
	loggingMode = config('logging.mode', 'sync')

# Instantiate logger
const Log\LoggerInterface = new createLogger(environment, {
	mode: loggingMode
})

export {
	getInstance,
	registerInstance,
	get,
	Log,
	register,
}
