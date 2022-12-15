import './app'
import { Log } from '../lib'

describe('integration test', () => {
    it('"Log.emergency" should return "Hello World"', () => {
        const logSpy = jest.spyOn(Log, 'emergency').mockImplementation(() => { })

        Log.emergency('Hello World')

        expect(logSpy.mock.calls).toContainEqual(['Hello World'])

        logSpy.mockRestore()
    })

    it('"Log.alert" should return "Hello World"', () => {
        const logSpy = jest.spyOn(Log, 'alert').mockImplementation(() => { })

        Log.alert('Hello World')

        expect(logSpy.mock.calls).toContainEqual(['Hello World'])

        logSpy.mockRestore()
    })

    it('"Log.critical" should return "Hello World"', () => {
        const logSpy = jest.spyOn(Log, 'critical').mockImplementation(() => { })

        Log.critical('Hello World')

        expect(logSpy.mock.calls).toContainEqual(['Hello World'])

        logSpy.mockRestore()
    })

    it('"Log.alert" should return "Hello World"', () => {
        const logSpy = jest.spyOn(Log, 'error').mockImplementation(() => { })

        Log.error('Hello World')

        expect(logSpy.mock.calls).toContainEqual(['Hello World'])

        logSpy.mockRestore()
    })

    it('"Log.warning" should return "Hello World"', () => {
        const logSpy = jest.spyOn(Log, 'warning').mockImplementation(() => { })

        Log.warning('Hello World')

        expect(logSpy.mock.calls).toContainEqual(['Hello World'])

        logSpy.mockRestore()
    })

    it('"Log.info" should return "Hello World"', () => {
        const logSpy = jest.spyOn(Log, 'info').mockImplementation(() => { })

        Log.info('Hello World')

        expect(logSpy.mock.calls).toContainEqual(['Hello World'])

        logSpy.mockRestore()
    })

    it('"Log.debug" should return "Hello World"', () => {
        const logSpy = jest.spyOn(Log, 'debug').mockImplementation(() => { })

        Log.debug('Hello World')

        expect(logSpy.mock.calls).toContainEqual(['Hello World'])

        logSpy.mockRestore()
    })

    it('"Log.log" should return "Hello World"', () => {
        const logSpy = jest.spyOn(Log, 'log').mockImplementation(() => { })

        Log.log('info', 'Hello World')

        expect(logSpy.mock.calls).toContainEqual(['info', 'Hello World'])

        logSpy.mockRestore()
    })

    it('"Log.channel" should add a new Log instance', () => {
        const log = Log.channel('test')

        expect(log._handlers.size).toBeGreaterThan(0)
    })

    it('"Log.channel" should throw an error', () => {
        expect(() => {
            Log.channel('random-channel')
        }).toThrowError('Logging config is missing')
    })
})
