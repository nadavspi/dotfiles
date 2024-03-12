function layout() {
	return {
		name: "Two pane custom",
		initialState: {
			mainCount: 1,
			mainRatio: 0.5
		},
		commands: {
			command1: {
				description: "Shrink main pane",
				updateState: (state) => {
					return { ...state, mainRatio: Math.max(0.1, state.mainRatio - 0.05) };
				}
			},
			command2: {
				description: "Expand main pane",
				updateState: (state) => {
					return { ...state, mainRatio: Math.min(0.9, state.mainRatio + 0.05) };
				}
			}
		},
		getFrameAssignments: (windows, screenFrame, state) => {
			const mainCount = Math.min(state.mainCount, windows.length);
			const secondaryCount = windows.length - mainCount;
			const hasSecondary = secondaryCount > 0;

			const mainHeight = screenFrame.height / mainCount;
			const secondaryHeight = screenFrame.height;

			const mainWidth = Math.round(screenFrame.width * state.mainRatio);
			const secondaryWidth = screenFrame.width - mainWidth;

			const mainX = () => {
				if (hasSecondary) {
					return screenFrame.x + secondaryWidth;
				}
				return (screenFrame.width - mainWidth) / 2;
			};

			return windows.reduce((frames, window, index) => {
				const isMain = index < mainCount;
				let frame;
				if (isMain) {
					frame = {
						x: mainX(),
						y: screenFrame.y,
						width: mainWidth,
						height: mainHeight
					};
				} else {
					frame = {
						x: screenFrame.x,
						y: screenFrame.y,
						width: secondaryWidth,
						height: secondaryHeight
					}
				}
				return { ...frames, [window.id]: frame };
			}, {});
		}
	};
}
