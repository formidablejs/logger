import { HandlerInterface } from "@livy/contracts/lib/handler-interface";

export class Driver<T = {}> {
    _options: T;
    constructor(options?: T);
    get options(): T;
    handler(): HandlerInterface;
}
