/** @brief The file format of a bcv video file.
 * @author Thomas Tsai thomas@life100.cc
 *
 */
#ifndef _H_BCV_VIDEO_FORMAT_H
#define	_H_BCV_VIDEO_FORMAT_H

//header is 256 bytes :0x100
#define	BCV_VIDEO_HEADER_SIZE		(256)
#define	BCV_VIDEO_FRAME_HEADER_SIZE	(32)

#define BCV_MAJOR_VER		(0u)
#define BCV_MINOR_VER		(70u)
#define BCV_VERSION			((BCV_MAJOR_VER)<<16 | (BCV_MINOR_VER & 0xffffu))	//0x0000 003c , v0.60

#define BCV_MAGIC_STR_LEN		(8)
#define BCV_VIDEO_HEADER_MAGIC	"biotrump"

//http://stackoverflow.com/questions/14179748/whats-the-difference-between-pragma-pack-and-attribute-aligned
/* 
 * push current alignment to stack
 * set alignment to 1 byte boundary
 */
#pragma pack(push, 1)
typedef struct _bcv_video_header{
	uint8_t magic[BCV_MAGIC_STR_LEN];		//8 bytes: "biotrump"
    uint32_t version;
	uint16_t width;
	uint16_t height;
	float fps;
	uint32_t pix_fmt;		//pixel format
	uint32_t total_frames;
	int16_t date_year;	//yyyy : mmdd: min : sec
	int16_t date_mmdd;
	int16_t date_hhmin;
	int16_t date_sec;
	uint8_t cam_name[16];
	/*
	 * NIR frames arragnement: B,L0,L1,L2,..Ln_1,B,L0,L1,L2,..Ln_1....
	 * We uses 3 different NIR LEDs, so the arragnement could be
	 * B,L0,L1,L2,B,L0,L1,L2,B,L0,L1,L2.....
	 * or 
	 * L0,L1,L2,L0,L1,L2,L0,L1,L2......
	 * 
	 * B, nir_baseline : 0, no base frame for ambient light before NIR LEDs are on.
	 * 					1, 1 baseline frame of ambient light before NIR LEDs are on.
	 * 					so this frame is a "baseline" for the later 3 L0, L1, L2 frames.
	 * 					L0' = L0 - B, L1'= L1 - B, L2' = L2 - B
	 *
	 */
	uint8_t nir_baseline;
	uint8_t nir_channels;	//total NIR wavelengths
	//v0.70 the used wavelengths like 730nm, 850nm, 940nm, unit is "nm"	
    uint8_t nir_lambda[198]; //198 = 256 - 58 ( size of meaningful information )
} BCV_VIDEO_HEADER, *PBCV_VIDEO_HEADER;

/*32 bytes frame header*/
typedef struct _bcv_video_frame{
	uint32_t index;		//ordinal number of the frame, incremental
	int16_t hr_bpm;		//referenced heart beat
	int16_t rr_bpm;		//referenced respiratory rate
	uint32_t interval;	//unit is 100 us
	//v0.70 the used wavelengths like 730nm, 850nm, 940nm, unit is "nm"
	uint16_t lamda;		//wavelength : unit nm
	int8_t eb_ts;		//time stamp is embedded in the first 32bits of the frame
    uint8_t reserved[17]; // 17 = 32 - 15
} BCV_VIDEO_FRAME_HEADER, *PBCV_VIDEO_FRAME_HEADER;
#pragma pack(pop)	/* restore original alignment from stack */

int bcvFileProcess(char *path);

#endif//_H_BCV_VIDEO_FORMAT_H
