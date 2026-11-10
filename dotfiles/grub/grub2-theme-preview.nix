{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  setuptools,
  wheel,
  OVMF,
}:

buildPythonPackage rec {
  pname = "grub2-theme-preview";
  version = "2.10.0";

  src = fetchFromGitHub {
    owner = "hartwork";
    repo = "grub2-theme-preview";
    rev = version;
    hash = "sha256-PRlVoPGToGUHfzTKYossiyusS4U1CTtHvnq4/7Zv7Dg=";
  };

  postPatch = ''
    substituteInPlace grub2_theme_preview/__main__.py \
      --replace-fail \
        "import signal" \
        "import shutil
    import signal"

    substituteInPlace grub2_theme_preview/__main__.py \
      --replace-fail \
        "    abs_tmp_folder = tempfile.mkdtemp()" \
        "    abs_tmp_folder = tempfile.mkdtemp(); abs_tmp_ovmf_vars_file = os.path.join(abs_tmp_folder, \"OVMF_VARS.fd\")"

    substituteInPlace grub2_theme_preview/__main__.py \
      --replace-fail \
        "    is_efi_host = \"efi\" in grub2_platform" \
        "    is_efi_host = \"efi\" in grub2_platform; is_efi_host and shutil.copyfile(\"${OVMF.fd}/FV/OVMF_VARS.fd\", abs_tmp_ovmf_vars_file)"

    substituteInPlace grub2_theme_preview/__main__.py \
      --replace-fail \
        "            options.qemu," \
        "            options.qemu, \"-machine\", \"q35\","

    substituteInPlace grub2_theme_preview/__main__.py \
      --replace-fail \
        "            f\"if=pflash,format=raw,readonly=on,file={omvf_image_path}\"," \
        "            f\"if=pflash,format=raw,unit=0,readonly=on,file={omvf_image_path}\", \"-drive\", f\"if=pflash,format=raw,unit=1,file={abs_tmp_ovmf_vars_file}\","

    substituteInPlace grub2_theme_preview/__main__.py \
      --replace-fail \
        "            os.remove(abs_tmp_img_file)" \
        "            os.remove(abs_tmp_img_file); is_efi_host and os.remove(abs_tmp_ovmf_vars_file)"
    substituteInPlace grub2_theme_preview/__main__.py \
      --replace-fail \
        "\"256\"," \
        "\"512\","

    substituteInPlace grub2_theme_preview/__main__.py \
      --replace-fail \
        "\"file=%s,index=0,media=disk,format=raw\" % abs_tmp_img_file," \
        "\"file=%s,index=0,media=cdrom,format=raw\" % abs_tmp_img_file, \"-boot\", \"order=d\","

  '';

  pyproject = true;

  build-system = [
    setuptools
    wheel
  ];

  doCheck = false;

  meta = {
    description = "preview a grub 2 theme using qemu";
    homepage = "https://github.com/hartwork/grub2-theme-preview";
    license = lib.licenses.gpl2Plus;
    mainProgram = "grub2-theme-preview";
  };
}
