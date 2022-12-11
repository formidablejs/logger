import { Application } from './app'
import { Log } from '../lib'
import type { Application as Instance } from '@formidablejs/framework'

describe('integration test', () => {
    let app: Instance = null

    beforeAll(async () => {
        app = await Application
    })

    it('should have config', () => {
        expect(app.config.get('logging', undefined)).toBeDefined()
    })

    it('should have configured Log instance', () => {
        expect(Log._handlers.size).toBeGreaterThan(0)
    })
})
