import { Driver } from "../Driver";
import { FileHandler } from "@livy/file-handler";

export class SingleDriver extends Driver {
    get path(): string;
    handler(): FileHandler;
}
