import { ConfigRepository } from '@formidablejs/framework'
import { LoggerServiceResolver } from '../../lib'

export class Config extends ConfigRepository {
    get registered() {
        return {
            app: {
                resolvers: [
                    LoggerServiceResolver
                ]
            },
            logging: {
                default: 'console',
                mode: 'sync',
                channels: {
                    console: {
                        driver: 'console',
                        level: 'debug'
                    },
                }
            }
        }
    }
}
