import { Application } from '@formidablejs/framework'
import { resolve } from 'path'
import { ConfigRepository } from '@formidablejs/framework'
import { ExceptionHandler } from '@formidablejs/framework'
import { Kernel as HttpKernel } from '@formidablejs/framework'
import { Config } from './config'
import { Handler } from './exceptions/Handler'
import { Kernel } from './http/Kernel'

let app = new Application(resolve('./'))

app
	.bind(ConfigRepository, Config)
	.bind(HttpKernel, Kernel)
	.bind(ExceptionHandler, Handler)
	.prepare()

export { app }
