import { ConfigRepository } from '@formidablejs/framework'
import type { HandlerInterface } from '@livy/contracts'

const state = {
	# @type {ConfigRepository}
	config: null
}

export class Driver
	constructor options = {}
		self._options = options

	# Return config from state
	get config\ConfigRepository
		state.config

	# Channel options
	get options
		self._options

	# Register handler
	def handler\HandlerInterface
		null

	# Put config in state.
	static def setConfig config\ConfigRepository
		if state.config
			throw new Error 'Config has already been set'

		state.config = config
