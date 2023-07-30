[
  (self: super: {
    aseprite-unfree = super.aseprite-unfree.overrideAttrs (attrs: {
      version = "1.3-beta21";
      postPatch = "";
    });
  })
]
