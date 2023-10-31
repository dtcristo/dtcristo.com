---
title: CRT and FPGA gaming
date: 2020-11-28 02:34 UTC
tags:
id: urn:uuid:864b7b2d-048f-4812-b8d5-09b1effffac1
---

With everyone else focused on the next-gen consoles, I've been going back in time. I recently picked up a used [Dell M992](https://icecat.biz/p/dell/200-23389/monitors+crt-m992-3606529.html) CRT monitor for both modern and vintage gaming. I have to say it's far better than I expected.

[![Dell M992 CRT monitor](images/crt-and-fpga-gaming/01.jpg)](images/crt-and-fpga-gaming/01.jpg)

It's a big boi, a whopping 18 inches of visible size. Happily fits on my filing cabinet next to my modern displays.

[![My desk and computer hardware](images/crt-and-fpga-gaming/02.jpg)](images/crt-and-fpga-gaming/02.jpg)

It's capable of up to 1600x1200@75Hz on one end and 640x480@160Hz on the other. As the resolution increases, the maximum refresh rate decreases. I feel the sweet spot is 1280x960@90Hz for Windows and modern games. 1024x768@120Hz is also very good for older shooters like Counter-Strike and Quake.

Vintage PC games have never looked better. Here is Diablo II running at glorious 800x600. It looks really nice and you have to really see it to believe it. No ugly scaling of the low resolution like you'd find on a modern display. The CRT handles it no worries with a super crisp image. There is an awesome glow from enemies in dark caves with heaps of detail visible.

[![Diablo II on CRT](images/crt-and-fpga-gaming/03.jpg)](images/crt-and-fpga-gaming/03.jpg)

I also booted up Doom (2016). My PC is not that powerful, but it is still capable of running this at max settings and >90 fps due to the lower resolution of 1280x960. It looks fantastic! Motion is superb with basically zero input lag.

[![Doom (2016) on CRT](images/crt-and-fpga-gaming/04.jpg)](images/crt-and-fpga-gaming/04.jpg)

If you want more material on modern CRT gaming, definitely check out this video from Digital Foundry.

<div class="video">
  <iframe
    class="video--iframe"
    src="https://www.youtube.com/embed/V8BVTHxc4LM"
    frameborder="0"
    allowfullscreen
  ></iframe>
</div>

At the same time as getting the CRT, I've also built a MiSTer FPGA retro gaming/computing system. It can emulate retro systems at a hardware level using an [FPGA](https://en.wikipedia.org/wiki/Field-programmable_gate_array) (think programmable hardware) rather than traditional software emulation. With a good core implementation, an FPGA has the potential to be 100% cycle accurate to the original system. MiSTer is an open source project that's regularly being updated with cores for new systems. Read about MiSTer on the [wiki](https://github.com/MiSTer-devel/Main_MiSTer/wiki) or watch this video from RMC.

<div class="video">
  <iframe
    class="video--iframe"
    src="https://www.youtube.com/embed/e5yPbzD-W-I"
    frameborder="0"
    allowfullscreen
  ></iframe>
</div>

The MiSTer is based around the [Terasic DE10-Nano](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&No=1046) development kit and features an Intel/Altera Cyclone V FPGA chip.

[![Terasic DE10-Nano](images/crt-and-fpga-gaming/05.jpg)](images/crt-and-fpga-gaming/05.jpg)

I've combined this with two optional boards (as well as an SDRAM module not pictured) purchased from [here](https://misterfpga.co.uk/). These provide USB ports, improved cooling, additional connectivity and more RAM.

[![MiSTer expansion boards](images/crt-and-fpga-gaming/06.jpg)](images/crt-and-fpga-gaming/06.jpg)

Here it is fully assembled.

[![MiSTer fully assembled](images/crt-and-fpga-gaming/07.jpg)](images/crt-and-fpga-gaming/07.jpg)

The MiSTer is capable of emulating a stack of systems. The main ones I've played with so far are NES, SNES, PC Engine, Genesis, Game Boy, GBA and Amiga. An on-screen display allows you to select the different systems and ROMs using USB keyboard or gamepad.

[![MiSTer OSD](images/crt-and-fpga-gaming/08.jpg)](images/crt-and-fpga-gaming/08.jpg)

Here it is running Super Mario World from the SNES.

[![Super Mario World on CRT](images/crt-and-fpga-gaming/09.jpg)](images/crt-and-fpga-gaming/09.jpg)

Most vintage gaming consoles output a 240p signal at 60Hz. Normal analogue TV signals are interlaced. NTSC is 480i@60Hz and PAL is 576i@50Hz. These consoles render one field of scanlines and leave the second field blank, hence you get a progressive signal with half the scanlines. This is why retro systems have visible scanlines on old TVs (because every alternate line is black). Most VGA CRT monitors are not capable of displaying a 240p signal directly as it would require a horizontal refresh of 15KHz, half the minimum supported 30KHz. To get this signal to display you have to do what's known as scan doubling. Essentially this renders each scanline twice, doubling the horizontal refresh from 15KHz to 30KHz putting the signal in the supported range and producing 480p. The MiSTer has a direct video output that can take raw signals from the core and output it to either a VGA port (or HDMI for use with a special HDMI-to-VGA adapter). This has zero lag. Scan doubling can be applied to this signal without introducing any more lag.

Here is Castlevania: Rondo of Blood (from the PC Engine) running at 480p.

[![Castlevania: Rondo of Blood in 480p](images/crt-and-fpga-gaming/10.jpg)](images/crt-and-fpga-gaming/10.jpg)

Another option is to double the refresh rate to 120Hz and keep the signal at 240 lines. You'll still end up with a 30KHz horizontal refresh and it will be in the range of the monitor. But it requires you to repeat frames twice. To produce 240p@120Hz you need to run the output through the integrated video scaler rather than using direct video. It uses a frame-buffer that will introduce up to one frame of input lag which may or may not be noticeable.

Here is Rondo of Blood in 240p.

[![Castlevania: Rondo of Blood in 240p](images/crt-and-fpga-gaming/11.jpg)](images/crt-and-fpga-gaming/11.jpg)

The scanlines on the monitor are quite thin, so this image is noticeably darker than the one in 480p. Text is also harder to read. But it is a nice trick and fun to look at scenes with the different video modes enabled. I generally prefer the 480p.

It's been fun nerding out with this hardware but that's all for now. Stay retro.
