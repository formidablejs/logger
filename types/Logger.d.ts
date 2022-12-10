import { Driver } from './Driver'
import { LoggerInterface } from '@livy/contracts'

export const Log: LoggerInterface;

/**
 * Register a Log Driver
 */
export const register: (name: string, driver: Driver) => void
