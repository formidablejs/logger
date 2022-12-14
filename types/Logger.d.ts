import { Driver } from './Driver'
import { LoggerInterface } from '@livy/contracts'

export interface Log extends LoggerInterface {
    /**
     * Use a different channel
     */
    channel: (name: string, options: any) => LoggerInterface
}

export const Log: Log;

/**
 * Register a Log Driver
 */
export const register: (name: string, driver: Driver) => void
