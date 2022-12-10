import { LogLevel } from '@livy/contracts'
import { LogRecordContext } from '@livy/contracts'

/**
 * Log with debug level
 */
export const debug: (message: string, context?: LogRecordContext) => unknown

/**
 * Log with info level
 */
export const info: (message: string, context?: LogRecordContext) => unknown

/**
 * Log with an arbitrary level
 */
export const log: (level: LogLevel, message: string, context?: LogRecordContext) => unknown
