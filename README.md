# Intel_8051_Assembly

Assembly Codes for MicroProcessor Class
(@Hanyang Univ. Prof David Wagner)

This programs only runs on `intel 8051 MicroProcessor`
`ARM`, `Motorola` MicroProcessors have differenct Assembly Grammer

---

## File Structure

Each Folder contains
- Assembly language
- *.prn files for Simulator
- *.hex files for 8051 Development Board

![structure](./IMAGES/PICTURES/MP_1.png)

### 1. Port Diodes Blinking and Shifting

- Control equipped Port Diodes
- Shifting Diode positions using Accumulator
- Basic Assembly Language Instructions (JMP, MOV, ORG, LOOP etc...) 

![NOP_OFF](https://user-images.githubusercontent.com/12381733/94684236-b8f9f780-0362-11eb-9eee-1ba4b3d2eebc.gif)


### 2. Delay Function

- Learn about 8051 registers
- Make 1 second delay using assembly language
- Debugging through register status

![SLOW_LED](https://user-images.githubusercontent.com/12381733/94684271-c7e0aa00-0362-11eb-85e1-77aab5257fa6.gif)

### 3. Handling Seven Segments

1. Rotate Segments

- Handle External Memory (using `DPTR`)
- Learn about Status Register `PSW`

![ROTATING_SEGMENT](https://user-images.githubusercontent.com/12381733/94684251-c1523280-0362-11eb-8014-9f1aed915ee9.gif)

> - Assignment
> 
> Write a program to display each number in order
> ![ROTATING_SEGMENT_NUMBER](https://user-images.githubusercontent.com/12381733/94684803-87cdf700-0363-11eb-899e-112c2b2bc75d.gif)

## Reference

- [MicroProcessor Class Hanyang Univ.]()