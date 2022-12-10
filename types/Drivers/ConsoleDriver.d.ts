export class ConsoleDriver extends Driver {
    handler(): ConsoleHandler;
}
import { Driver } from "../Driver";
import { ConsoleHandler } from "@livy/console-handler";
