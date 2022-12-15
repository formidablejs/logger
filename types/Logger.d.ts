import { Driver } from './Driver'
import { LoggerInterface } from '@livy/contracts'

type ChannelOptions = {
    mode: 'async' | 'sync'
}

export interface Log extends LoggerInterface {
    /**
     * Use a different channel
     */
    channel: (name: string, options?: ChannelOptions) => LoggerInterface
}

export const Log: Log;

/**
 * Register a Log Driver
 */
export const register: (name: string, driver: Driver) => void
