import { GroupHandler } from '@livy/group-handler'
import { Driver } from '../Driver'
import { get } from '../Logger'
import type { HandlerInterface } from '@livy/contracts'

export class StackDriver < Driver

	get handlers\Array<HandlerInterface>
		const channels = self.options.channels

		if !Array.isArray(channels)
			throw new TypeError "Expected channels to be of type Array"

		const handlers = []

		for name in channels
			const channel = self.config.get("logging.channels.{name}")

			const driver = get(channel.driver)

			handlers.push (new driver(channel)).handler!

		handlers

	def handler
		new GroupHandler(handlers, self.options)
