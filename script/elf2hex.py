import os
import argparse
from elftools.elf.elffile import ELFFile

def swap_bytes(input_string):
    if len(input_string) % 2 != 0:
        raise ValueError("Input string length must be even.")
    bytes_list = [input_string[i:i+2] for i in range(0, len(input_string), 2)]
    return ''.join(reversed(bytes_list))

def elf_to_raw_binary(input_elf_path, output_bin_path):
    with open(input_elf_path, 'rb') as elf_file:
        elf = ELFFile(elf_file)

        with open(output_bin_path, 'wb') as bin_file:
            for segment in elf.iter_segments():
                if segment['p_type'] == 'PT_LOAD':
                    bin_file.seek(segment['p_paddr'])
                    bin_file.write(segment.data())

    print(f"Converted ELF to binary: {output_bin_path}")

def elf_to_coe_and_readmemh(input_file, coe_file, readmemh_file):
    try:
        with open(input_file, 'rb') as elf_file, \
             open(coe_file, 'w') as coe_out, \
             open(readmemh_file, 'w') as readmemh_out:

            elf = ELFFile(elf_file)

            coe_out.write("; Xilinx COE file generated from ELF\n")
            coe_out.write("memory_initialization_radix=16;\n")
            coe_out.write("memory_initialization_vector=\n")

            data_lines = []
            readmemh_lines = []

            for segment in elf.iter_segments():
                if segment['p_type'] == 'PT_LOAD':
                    segment_data = segment.data()
                    for i in range(0, len(segment_data), 4):
                        word = segment_data[i:i+4].ljust(4, b'\x00')
                        hex_value = ''.join(f'{b:02X}' for b in word)
                        hex_value = swap_bytes(hex_value)
                        data_lines.append(hex_value)
                        readmemh_lines.append(hex_value)

            coe_out.write(",\n".join(data_lines) + ";\n")
            readmemh_out.write("\n".join(readmemh_lines) + "\n")

            print(f"Generated COE: {coe_file}")
            print(f"Generated inst.pat: {readmemh_file}")
    except Exception as e:
        print(f"Error: {e}")

def main():
    parser = argparse.ArgumentParser(description="Convert ELF to COE, .pat, and binary.")
    parser.add_argument("-i", "--input" , required=True,  help="input ELF file path")
    parser.add_argument("-o", "--output", required=True,  help="output directory path")
    parser.add_argument("-f", "--file"  , required=False, help="file type coe or mi default set to coe")
    file_type = "coe"
    args = parser.parse_args()
    input_elf_file = args.input
    output_dir     = args.output
    if args.file is not None:
      file_type = args.file

    if not os.path.isfile(input_elf_file):
        print(f"Error: input ELF file '{input_elf_file}' not found.")
        return

    os.makedirs(output_dir, exist_ok=True)

    output_coe_file = os.path.join(output_dir, "imem.coe")
    output_readmemh_file = os.path.join(output_dir, "inst.pat")
    output_bin_file = os.path.join(output_dir, "prog.bin")

    elf_to_coe_and_readmemh(input_elf_file, output_coe_file, output_readmemh_file)
    elf_to_raw_binary(input_elf_file, output_bin_file)

if __name__ == "__main__":
    main()
