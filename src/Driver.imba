import { HandlerInterface } from '@livy/contracts'

export class Driver
	constructor options = {}
		self._options = options

	# Channel options
	get options
		self._options

	# Register handler
	def handler\HandlerInterface
		null
