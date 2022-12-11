import { Driver } from '../Driver'
import { GroupHandler } from '@livy/group-handler'
import { HandlerInterface } from '@livy/contracts'

export class StackDriver extends Driver {
    get handlers(): Array<HandlerInterface>
    handler(): GroupHandler
}
