export class DailyDriver extends Driver {
    /**
    @returns { string }
    */
    get path(): string;
    handler(): FileHandler;
}
import { Driver } from "../Driver";
import { FileHandler } from "@livy/file-handler";
