import { ServiceResolver } from '@formidablejs/framework'
import { Driver } from './Driver'
import { ConsoleDriver } from './Drivers/ConsoleDriver'
import { DailyDriver } from './Drivers/DailyDriver'
import { SingleDriver } from './Drivers/SingleDriver'
import { SlackDriver } from './Drivers/SlackDriver'
import { StackDriver } from './Drivers/StackDriver'
import { DiscordDriver } from './Drivers/DiscordDriver'
import { ConfigMissingException } from './Exceptions/ConfigMissingException'
import { get } from './Logger'
import { Log } from './Logger'
import { register } from './Logger'
import type { HandlerInterface } from '@livy/contracts'

export class LoggerServiceResolver < ServiceResolver

	get channel\any
		const name = self.app.config.get('logging.default')

		self.app.config.get("logging.channels.{name}")

	get handler\HandlerInterface
		if !self.channel
			throw new ConfigMissingException "Logging config is missing"

		const driver = get(self.channel.driver)

		(new driver(channel)).handler!

	def boot
		Driver.setConfig(self.app.config)

		register('stack', StackDriver)
		register('single', SingleDriver)
		register('daily', DailyDriver)
		register('console', ConsoleDriver)
		register('slack', SlackDriver)
		register('discord', DiscordDriver)

		Log.handlers.add(self.handler)
