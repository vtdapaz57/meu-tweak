%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)application {
    %orig;
    NSLog(@"Tweak carregado com sucesso!");
}
%end
