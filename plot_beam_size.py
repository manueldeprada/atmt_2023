import json
from matplotlib.lines import Line2D
import matplotlib.pyplot as plt
import matplotlib.colors as mcolors
import numpy as np
from matplotlib.collections import LineCollection

# Function to read data from a JSONL file and extract relevant information
def read_data(file_path):
    beam_sizes = []
    bleu_scores = []
    bp_values = []
    elapsed_times = []

    with open(file_path, 'r') as file:
        for line in file:
            data = json.loads(line)
            beam_sizes.append(data['beam_size'])
            bleu_scores.append(data['bleu'])
            bp_values.append(data['bp'])
            elapsed_times.append(data['elapsed_t'])
            
    # bleu_scores = np.array(bleu_scores) * 1/np.array(bp_values)
    
    return beam_sizes, bleu_scores, bp_values, elapsed_times

# Function to create the plot
def create_plot(beam_sizes, bleu_scores, bp_values, elapsed_times):
    # Prepare the colormap
    norm = mcolors.Normalize(vmin=min(elapsed_times), vmax=max(elapsed_times))
    cmap = plt.cm.viridis

    # Create the plot
    fig, ax1 = plt.subplots()
    
    
    # Scatter plot for BLEU scores with colored points
    sc = ax1.scatter(beam_sizes, bleu_scores, c=elapsed_times, cmap=cmap, norm=norm)

    # Create a continuous colored line for BLEU scores
    points = np.array([beam_sizes, bleu_scores]).T.reshape(-1, 1, 2)
    segments = np.concatenate([points[:-1], points[1:]], axis=1)
    lc = LineCollection(segments, cmap=cmap, norm=norm)
    lc.set_array(np.array(elapsed_times))
    lc.set_linewidth(2)
    ax1.add_collection(lc)

    # Create a colorbar for the BLEU line
    cbar = plt.colorbar(lc, ax=ax1, pad=0.15)
    cbar.set_label('Elapsed Time (s)')

    # Plot Brevity Penalty on a second y-axis
    ax2 = ax1.twinx()
    ax2.plot(beam_sizes, bp_values, color='r', label='Brev. Penalty')
    ax2.spines['right'].set_color('red')
    ax2.spines['right'].set_linewidth(2)

    # Set the labels and title
    ax1.set_ylim([20,27])
    ax1.set_xlabel('Beam Size')
    ax1.set_ylabel('BLEU Score')
    ax2.set_ylabel('Brevity Penalty', color='r')
    ax2.tick_params('y', colors='r')
    ax2.set_ylim([0.6, 1.2])
    # plt.title('BLEU Scores and Brevity Penalty vs Beam Size', pad=20)

    # Add legends
    # ax1.legend(loc='upper left')
    
    
    #add to ax2 legend a pointed line that is titled "BLEU Score"
    legend_elements = [Line2D([0], [0], label='BLEU Score', marker='o', color=cmap(norm(0.5))),
                   Line2D([0], [0], color='r', label='Brev. Penalty')]

    # Add the custom legend
    ax2.legend(handles=legend_elements, loc='upper right')
    

    plt.savefig('beam_search_k.png')

# Main function
def main():
    # Path to the JSONL file
    file_path = 'beam_search_k.jsonl'  # Update this with your file path

    # Read data from the file
    beam_sizes, bleu_scores, bp_values, elapsed_times = read_data(file_path)

    # Create and display the plot
    create_plot(beam_sizes, bleu_scores, bp_values, elapsed_times)

if __name__ == "__main__":
    main()
